module Main where

-- Implement Fibonacci numbers using tail recursion.
-- Use pattern matching for the case of fib 0 = 1 and fib 1 = 1.
-- Use a tail-recursive (iterative implementation) for the rest.

-- There is an example of how to do this here:
-- http://stackoverflow.com/questions/13042353/does-haskell-have-tail-recursive-optimization

-- Add the type signature before the function is defined.
-- Think specifically about what typeclass its parameters should be.
-- Write a plain-English description of how to read and understand it.

-- The autograder will test you on large numbers; if you submit the
-- usual doubly-recursive implementation, it will take too long and
-- Bottlenose will time out.

-- If you haven't solved this and you want to get credit for the rest
-- of your work, back off to the starter code and at least you won't
-- cause Bottlenose to hang.



--tail recursive
fibi :: (Num t, Integral t1) => t1 -> t
--fibi :: (Num t, Num t1, Eq t1) => t1 -> t
fibi x = fibi' x 1 1 where
    fibi' 0 y z = z
    fibi' 1 y z = z
    fibi' x y z = fibi' (x-1) z (z + y)

--Description:
--The tail recursion (iterative) Fibonacci is using a helper function
--to implement it. the helper function fibi' taking 3 parameters. the first parameter
--will be decrement 1 for each iteration. the second parameter will hold the
--third parameter value while the third parameter is the result that add from the second.
--the result is store at the third parameter and will return when the counter is either 1 or 0;




-- don't change anything below this line;
-- this code is for communication with the autograder.

main = do
  l <- getLine
  putStr $ show $ fibi (read l :: Integer)
