--module Main where

-- Modify the myAbs function to work properly.
-- Use pattern matching for the zero case,
-- and guards for positive or negative inputs.

-- Add the type signature before the function is defined.
-- Think specifically about what typeclass its parameters should be.
-- Write a plain-English description of how to read and understand it.

--myAbs x = x


myAbs :: (Ord a, Integral a) => a -> a
myAbs 0 = 0
myAbs x | x >= 0 = x | otherwise = x * (-1)

--Description:
--The function is using the pattern matching for the zero case,
--it also guards for given input number. It takes one parameter
--and return a positive number if the input number is greater than 0
--or it will multiply by (-1) if the input number is less than 0





-- don't change anything below this line;
-- this code is for communication with the autograder.

--main = do
--  l <- getLine
--  putStr $ show $ myAbs (read l :: Float)
