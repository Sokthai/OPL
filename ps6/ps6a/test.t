#!/usr/bin/perl
use 5.10.0;
 
use Test::Simple tests => 32;

use IO::Handle;

our $OUTPUT = "/tmp/out.$$.txt";

my $binary = "error";

sub test_exp {
    my ($exp) = @_;

    open my $pipe, "|./$binary > $OUTPUT";
    $pipe->say($exp);
    close $pipe;

    my $result = `cat $OUTPUT`;
    unlink($OUTPUT);

    $result =~ s/\n//g;
    #$result =~ s/\s//g;
    $result =~ s/.*\)//;
    
    return $result;
}

$binary = "Fib";
ok(test_exp("0") == 1, "$binary: fib of 0 is 1");
ok(test_exp("1") == 1, "$binary: fib of 1 is 1");
ok(test_exp("2") == 2, "$binary: fib of 2 is 2");
ok(test_exp("10") == 89, "$binary: fib of 10 is 89");
ok(test_exp("20") == 10946, "$binary: fib of 20 is 10946");

$binary = "MyAbs1";
ok(test_exp("3") == 3, "$binary: positive integer");
ok(test_exp("0") == 0, "$binary: zero");
ok(test_exp("-17") == 17, "$binary: negative integer");
ok(test_exp("2.5") == 2.5, "$binary: positive float");
ok(test_exp("-12.1") == 12.1, "$binary: negative float");

$binary = "MyAbs2";
ok(test_exp("3") == 3, "$binary: positive integer");
ok(test_exp("0") == 0, "$binary: zero");
ok(test_exp("-17") == 17, "$binary: negative integer");
ok(test_exp("2.5") == 2.5, "$binary: positive float");
ok(test_exp("-12.1") == 12.1, "$binary: negative float");

$binary = "SquareList1";
ok(test_exp("1 2 3") eq "1 4 9", "$binary: list of three nums");
ok(test_exp("") eq "", "$binary: empty list");
ok(test_exp("22 33 55 93472") eq "484 1089 3025 8737014784", 
    "$binary: list of three bigger nums");

$binary = "Distance";
ok(test_exp("0 0 3 4") == "5.0", "$binary: distance ((0,0),(3,4)) is 5.0");
ok(test_exp("0 0 0 0") == "0.0", "$binary: distance ((0,0),(0,0)) is 0.0");
ok(test_exp("1 2 3 4") == "2.8284271247461903", "$binary: distance ((1,2),(3,4)) is 2.8284271247461903");

$binary = "DivBySeven";
ok(test_exp("") eq "", "$binary: empty list");
ok(test_exp("0 2 7") eq "0 7", "$binary: list of three nums");
ok(test_exp("0 2 7 14 21 654304") eq "0 7 14 21 654304", "$binary: longer list of nums");

$binary = "SumList";
ok(test_exp("1 2 3") == 6, "$binary: list of three nums");
ok(test_exp("") == 0, "$binary: empty list");
ok(test_exp("54 3 2 1") == 60, "$binary: slightly longer list");

$binary = "FibIter";
ok(test_exp("30") == 1346269, "$binary: fib of 30 is 1346269");
ok(test_exp("50") == 20365011074, "$binary: fib of 50 is 20365011074");
ok(test_exp("60") == 2504730781961, "$binary: fib of 60 is 2504730781961");
ok(test_exp("100") == 573147844013817084101, "$binary: fib of 100 is 573147844013817084101");
ok(test_exp("1000") == 70330367711422815821835254877183549770181269836358732742604905087154537118196933579742249494562611733487750449241765991088186363265450223647106012053374121273867339111198139373125598767690091902245245323403501, "$binary: fib of 1000 is 70330367711422815821835254877183549770181269836358732742604905087154537118196933579742249494562611733487750449241765991088186363265450223647106012053374121273867339111198139373125598767690091902245245323403501");

