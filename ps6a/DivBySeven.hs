module Main where

-- Write a function named "divBySeven" that takes a list of numbers
-- and returns a list of numbers that are divisible by 7
-- (in the same order that they appeared in the original list).

-- See http://learnyouahaskell.com/recursion for guidance.

-- See http://stackoverflow.com/questions/5891140/difference-between-mod-and-rem-in-haskell
-- and know that your function will only be tested on non-negative
-- integers.

-- Add the type signature before the function is defined.
-- Think specifically about what typeclass its parameters should be.
-- Write a plain-English description of how to read and understand it.

-- note: 'id' is the identity function, so you're starting out with
-- a function that returns its input.
-- this is clearly not the answer; it's only given so you have
-- something which will compile.
divBySeven = id






-- don't change anything below this line;
-- this code is for communication with the autograder.

main = do  
  l <- getLine
  putStr $ unwords $
    map show
    (divBySeven (map (\x -> read x :: Int) (words l)))
