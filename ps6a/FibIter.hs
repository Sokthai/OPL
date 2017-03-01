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

fibi n = 1




-- don't change anything below this line;
-- this code is for communication with the autograder.

main = do  
  l <- getLine
  putStr $ show $ fibi (read l :: Int)
          
  
