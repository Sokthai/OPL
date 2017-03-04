module Main where

-- Modify the myAbs function to work properly.
-- Use an if-then-else expression.

-- Add the type signature before the function is defined.
-- Think specifically about what typeclass its parameters should be.
-- Write a plain-English description of how to read and understand it.

--myAbs x = x



--myAbs :: Float -> Float
myAbs :: (Num t, Ord t) => t -> t
myAbs x = (if x < 0 then x * (-1) else x)

--Description
--This function will require a float input argument
--and return the positive number.
--it check to see if the value of 'x' is less than
--0 then it multiply with (-1) and else it would
--just return the value of 'x'



-- don't change anything below this line;
-- this code is for communication with the autograder.

main = do  
  l <- getLine
  putStr $ show $ myAbs (read l :: Float)
          
  
