module Main where

-- Modify the myAbs function to work properly.
-- Use pattern matching for the zero case, 
-- and guards for positive or negative inputs.

-- Add the type signature before the function is defined.
-- Think specifically about what typeclass its parameters should be.
-- Write a plain-English description of how to read and understand it.

myAbs x = x






-- don't change anything below this line;
-- this code is for communication with the autograder.

main = do  
  l <- getLine
  putStr $ show $ myAbs (read l :: Float)
          
  
