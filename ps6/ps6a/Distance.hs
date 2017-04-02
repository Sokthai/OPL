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

third (b, c, z) = z

distance :: Floating a => ((a, a), (a, a)) -> a
distance ((x1, y1), (x2, y2)) = sqrt((x1 - x2)^2 + (y1 - y2)^2)
--distance x = sqrt((fst (fst x) - (fst (snd x)))^2 + (snd (fst x) - (snd (snd x)))^2)



--Description :
--the distance function is taking one tuple with two inner tuples.
--the ((x1, y1), (x2, y2)) of the distance parameter are represented the
--two inner tuples coordinates of the plane.
--use the formula given above, sqrt ((x1-x2)^2 + (y1-y2)^2), to calculator the result








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
