module Main where

-- Modify the myAbs function to work properly.
-- Use pattern matching for the zero case,
-- and guards for positive or negative inputs.

-- Add the type signature before the function is defined.
-- Think specifically about what typeclass its parameters should be.
-- Write a plain-English description of how to read and understand it.

--myAbs x = x

--myAbs :: (Float x) => x -> x
--myAbs x = x | x >= 0 = x | otherwise = x * (-1)

bmiTell :: (RealFloat a) => a -> String
bmiTell bmi
    | bmi <= 18.5 = "You're underweight, you emo, you!"
    | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
    | bmi <= 30.0 = "You're fat! Lose some weight, fatty!"
    | otherwise   = "You're a whale, congratulations!"  


-- don't change anything below this line;
-- this code is for communication with the autograder.

main = do
  l <- getLine
  putStr $ show $ myAbs (read l :: Float)
