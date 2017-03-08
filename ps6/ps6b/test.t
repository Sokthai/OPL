#!/usr/bin/perl
use 5.10.0;
use warnings FATAL => 'all';

use File::Temp;
use File::Copy;
use IO::Handle;

our $OUTPUT = "/tmp/out.$$.txt";

my $fname = "ps.hs";

sub haskell_eval {
    my ($cmdline) = @_;
    my $tmpcode = File::Temp->new;
    copy($fname, $tmpcode) or die "Copy failed: $!";
    open(my $fh, '>>', $tmpcode);
    $fh->say('

main = do  
  putStr $ show $ '.$cmdline.' 

');
    open my $pipe, "| runhaskell $tmpcode > $OUTPUT";
    $pipe->say($cmdline);
    close $pipe;
    my $result = `cat $OUTPUT`;
    unlink($OUTPUT);
    $result =~ s/\n//g;
    $result =~ s/.*\)//;
    return $result;
}

my $binary="ps";
# uses $binary as global and appends ".hs" to search source
sub filesearch {
    my ($exp) = @_;
    open my $fh, $binary.".hs" or die;
    while (my $line = <$fh>) {
	if ((index $line, $exp) >=0) {
	    return 1;
	}
    }
    return 0;
}


use Test::Simple tests => 14;

$fname = "ps.hs";

ok(haskell_eval("zeroIsNothing 0") eq "Nothing", "zeroIsNothing 0");
ok(haskell_eval("zeroIsNothing 5") eq "Just 5", "zeroIsNothing 5");

ok(haskell_eval("nothingIsZero Nothing") eq "0", "nothingIsZero Nothing");
ok(haskell_eval("nothingIsZero (Just 5)") eq "5", "nothingIsZero (Just 5)");

ok(haskell_eval("getNum (makeNum 5)") eq "Just 5", "NumOrString numbers Just");
ok(haskell_eval("getString (makeNum 5)") eq "Nothing", "NumOrString numbers Nothing");

ok(haskell_eval("getString (makeString \"foo\")") eq "Just \"foo\"", "NumOrString strings Just");
ok(haskell_eval("getNum (makeString \"foo\")") eq "Nothing", "NumOrString strings Nothing");

ok(haskell_eval("map getNum (makeNumList 0)") eq "[]", "makeNumList 0");
ok(haskell_eval("map getNum (makeNumList 5)") eq "[Just 1,Just 2,Just 3,Just 4,Just 5]", "makeNumList 5");

ok(haskell_eval("bucket_op 4 []") eq "[[4]]", "bucket_op 4 []");
ok(haskell_eval("bucket_op 4 [[4]]") eq "[[4,4]]", "bucket_op 4 [[4]]");
ok(haskell_eval("bucket_op 5 [[4,4]]") eq "[[5],[4,4]]", "bucket_op 5 [[4,4]]");
ok(haskell_eval("bucket [1,2,2,3,4,4,4,2,1,1,0]") eq "[[1],[2,2],[3],[4,4,4],[2],[1,1],[0]]", "bucket [1,2,2,3,4,4,4,2,1,1,0]");
