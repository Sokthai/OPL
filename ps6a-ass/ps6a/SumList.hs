module Main where

-- Write a function named 'sumList' that takes a list of numbers
-- and returns the sum of the list.

-- You should use pattern matching to define the edge case,
-- which is that the sum of an empty list is 0.

-- see http://learnyouahaskell.com/recursion for guidance.

-- Add the type signature before the function is defined.
-- Think specifically about what typeclass its parameters should be.
-- Write a plain-English description of how to read and understand it.

--sumList _     = 0

sumList :: Num a => [a] -> a
sumList [] = 0
sumList (x:xs) = x + sumList xs


--Description
--The sumList takes one list of number and sum all element in the list
--if the list is empty, it will return 0 else
--it will recursively add each element in the list return the sum.



-- don't change anything below this line;
-- this code is for communication with the autograder.

main = do
  l <- getLine
  putStrLn $ show $
    (sumList (map (\x -> read x :: Int) (words l)))
