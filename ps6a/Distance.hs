module Main where

-- Write a function named "distance" that takes a tuple of two items,
-- each being a tuple of two numbers.  Assume that the two inner tuples
-- represent (x, y) coordinates on a plane, and output the distance
-- between the two points -- i.e., sqrt ((x1-x2)^2 + (y1-y2)^2).

-- Realize that the distance function just takes a single parameter
-- a tuple (of two tuples).

-- read:
-- http://learnyouahaskell.com/starting-out#tuples

-- you may also wish:
-- http://learnyouahaskell.com/syntax-in-functions#where
-- http://learnyouahaskell.com/syntax-in-functions#let-it-be

-- Add the type signature before the function is defined.
-- Think specifically about what typeclass its parameters should be.
-- Write a plain-English description of how to read and understand it.



tuple1  = (5, 6)
tuple2  = (3, 2)
tuple = (tuple1, tuple2)

--distance _ = (fst tuple1 - fst tuple2)^2 + (snd tuple1 - snd tuple2)^2

distance x = sqrt((fst (fst x) - (fst (snd x)))^2 + (snd (fst x) - (snd (snd x)))^2)


--distance x = (a^2 + b^2 | (a,b) <- x, a )


removeNonUppercase :: [Char] -> [Char]
removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]

lucky :: (Integral a) => a -> String
lucky 7 = "lucky number 7"
lucky 6 = "lucky number 6"
lucky x = "not the right number"

factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial n = n * factorial (n - 1)

addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)
--addVectors a b = (fst a + fst b, snd a + snd b)
addVectors (x1, y1) (x2, y2) = (x1 - x2, y1 - y2)

-- don't change anything below this line;
-- this code is for communication with the autograder.

-- read four numbers separated by spaces as Doubles,
-- then make them into a tuple of tuples and hand off to distance.
main = do
  l <- getLine
  let nums = map (\x -> read x :: Double) (words l)
      x1 = nums!!0
      y1 = nums!!1
      x2 = nums!!2
      y2 = nums!!3
  putStr $ show $ distance ((x1, y1), (x2, y2))
