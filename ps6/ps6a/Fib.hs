module Main where

-- Implement Fibonacci numbers using recursion.
-- Use pattern matching for the case of fib 0 = 1 and fib 1 = 1.
-- Use recursion for the rest.

-- Add the type signature before the function is defined.
-- Think specifically about what typeclass its parameters should be.
-- Write a plain-English description of how to read and understand it.

-- the below is wrong: it says the fib of any number is 1.
-- so it'll pass a couple of tests, but don't get too excited.



fib :: (Integral a, Num b) => a -> b
--fib :: (Eq a1, Num a, Num a1) => a1 -> a
fib 0 = 1
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)

--Description:
--This recursion fib function is taking one parameter,
--and it will produce the Fibonacci result.
--for instance,
--fib 3 => fib 2 + fib 1 => fib 1 + fib 0 + fib 1 = 1 + 1 + 1 = 3



--multThree :: (Num a) => a -> a -> a -> a
multThree :: (Num a) => a -> (a -> (a -> a))
multThree a b c = a * b * c


removeNonUppercase :: [Char] -> [Char]  
removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']] 


t xs = [ b * 2 | x <- xs, let b = x + 1,  x > 3]

divideByTen :: (Floating a) => a -> a  
divideByTen x = (x/10) 

lucky :: Int -> String  
lucky 7 = "LUCKY NUMBER SEVEN!"  
lucky x = "Sorry, you're out of luck, pal!"  

-- don't change anything below this line;
-- this code is for communication with the autograder.

main = do
  l <- getLine
  putStr $ show $ fib (read l :: Int)
