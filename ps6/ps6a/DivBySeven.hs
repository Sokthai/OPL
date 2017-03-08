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

--divBySeven = id

divBySeven :: (Integral t) => [t] -> [t]
divBySeven x = [a | a <- x, a `mod` 7 == 0]

--divBySeven [] = []
--divBySeven (x:xs) = if x `mod` 7 == 0 
--					then x:divBySeven xs
--					else divBySeven xs

--http://learnyouahaskell.com/starting-out#im-a-list-comprehension



--Description
--This divBySeven function will take a parameter of list
--and return a list of any element that is divisible by 7.
--it uses a guard to filter out any number that has zero remainder
--when doing the modular operation. if the remainder is zero,
--it will pass that number to 'a' then will form a list due to the
--square bracket




-- don't change anything below this line;
-- this code is for communication with the autograder.

main = do
  l <- getLine
  putStr $ unwords $
    map show
    (divBySeven (map (\x -> read x :: Int) (words l)))
