module Main where

-- Modify the myAbs function to work properly.
-- Use an if-then-else expression.

-- Add the type signature before the function is defined.
-- Think specifically about what typeclass its parameters should be.
-- Write a plain-English description of how to read and understand it.

--myAbs x = x



--myAbs :: Float -> Float
myAbs :: (Num a, Ord a) => a -> a
myAbs x = (if x < 0 then x * (-1) else x)

--Description
--This function will require a parameter
--this function using if-then-else statement
--to check if the given number is less than 0.
--if the value of 'x' is less than
--0, it will multiply it with (-1), or it would
--just return the value of 'x'



-- don't change anything below this line;
-- this code is for communication with the autograder.

main = do
  l <- getLine
  putStr $ show $ myAbs (read l :: Float)
