module Main where

-- Write a function named "squareList" which will take a list of numbers 
-- and output a list where each item is squared.
--
-- Use recursion to accomplish this (not mapping).
-- see http://learnyouahaskell.com/recursion for guidance.

-- Add the type signature before the function is defined.
-- Think specifically about what typeclass its parameters should be.
-- Write a plain-English description of how to read and understand it.

-- use t (not a) as the variable holding the type info.

-- note: 'id' is the identity function, so you're starting out with
-- a function that returns its input.
-- this is clearly not the answer; it's only given so you have
-- something which will compile.
squareList = id





-- don't change anything below this line;
-- this code is for communication with the autograder.

main = do  
  l <- getLine
  putStr $ unwords $
    map show
    (squareList (map (\x -> read x :: Int) (words l)))
          
  
