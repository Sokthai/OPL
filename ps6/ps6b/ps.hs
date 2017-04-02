-- This material prepared by Fred Martin, fred_martin@uml.edu
-- Sat Mar  4 21:34:54 2017

-- This Haskell problem set covers:
--  * type signatures
--  * work with Maybe, Nothing, and Just
--  * defining your own typeclass
--  * the bucket problem redux

-- what is the type signature of :    (>6)
--
-- A.  Num -> Bool
-- B.  (Num a, Ord a) => a -> Bool
-- C.  Ord -> Bool
-- D.  (Num a) => a -> Bool
-- E.  none of these
-- put letter A - E in the quotes to specify the correct answer.
gt6num = "B"


-- what is the type signature of:   (> (6 :: Integer))
--
-- A.  (Num a, Ord a) => a -> Bool
-- B.  (Integral a) => a -> Bool
-- C.  Integer -> Bool
-- D.  Num -> Bool
-- E.  none of these
-- put letter A - E in the quotes to specify the correct answer.
gt6int = "C"


-- which of the following map expressions may legitimately be
-- evaluated?
--
-- A.  map (*2) [1..5]
-- B.  map (>3) [1..5]
-- C.  map (==2) [1..5]
-- D.  A, B, and C are all fine
-- E.  none of A, B, or C will work
-- put letter A - E in the quotes to specify the correct answer.
mapq = "D"



-- Which of these following function definitions will correctly map 0
-- to True and other numbers to False?
--
-- A.
-- myfun 0 :: Int -> True
-- myfun z = False
--
-- B.

--myfun :: Num a => a -> Bool
--myfun 0 = True
--myfun z = False
--
-- C.
--myfun :: (Int a) => a -> Bool
--myfun 0 = True
--myfun z = False
--
-- D.
--myfun :: Int -> Bool
--myfun 0 = True
--myfun z = False

--
-- E. none of these
--
-- put letter A - E in the quotes to specify the correct answer.


myfun = "D"


myfun1 0 = True
myfun1 z = False


-- some exercises with Maybe, Nothing, and Just a
-- read this section first:
-- http://learnyouahaskell.com/making-our-own-types-and-typeclasses#type-parameters

-- write a function "zeroIsNothing" which
-- converts 0 to Nothing, and any other number to Just that number
-- also write its type signature


--zeroIsNothing :: (Eq a, Num a) => a -> Maybe a
zeroIsNothing :: (Integral a) => a -> Maybe a
zeroIsNothing 0 = Nothing
zeroIsNothing z = Just z



-- write a function "nothingIsZero" which
-- converts Nothing to 0, and (Just a) to the number a
-- also write its type signature

--nothingIsZero :: Integer => Maybe a -> a
--nothingIsZero :: (Eq a, Num a) => Maybe a -> a
nothingIsZero :: Maybe Integer -> Integer
nothingIsZero (Just a) = a
nothingIsZero Nothing = 0



-- Create a typeclass called NumOrString that can contain either an
-- Integer or String object.
-- see
-- http://learnyouahaskell.com/making-our-own-types-and-typeclasses#algebraic-data-types
-- and http://learnyouahaskell.com/making-our-own-types-and-typeclasses#type-synonyms
--
-- make sure your NumOrString class includes "deriving (Show)" so that
-- it may be printed


data NumOrString = Num Integer | String String deriving (Show)



-- write a function makeNum
-- which accepts an Integer and produces a NumOrString object that
-- encapsulates its value
-- also write its type signature


makeNum :: Integer -> NumOrString
makeNum a = Num a







-- write a function getNum which accepts a NumOrString object and
-- produces a Maybe object, where
-- if the NumOrString object is a number, it should be "Just <that
-- number>"
-- otherwise, Nothing
-- also write its type signature

getNum :: NumOrString -> Maybe Integer
getNum (String a) = Nothing
getNum (Num a) = Just a











-- write a function makeString
-- which accepts a String and produces a NumOrString object that
-- encapsulates its value
-- also write its type signature

makeString :: String -> NumOrString
makeString a = String a





-- write a function getString which accepts a NumOrString object and
-- produces a Maybe object, where
-- if the NumOrString object is a String, it should be "Just <that
-- string>"
-- otherwise, Nothing
-- also write its type signature

getString :: NumOrString -> Maybe String
getString (Num a) = Nothing
getString (String a) = Just a


-- write a function named "makeNumList" which accepts a numeric argument
-- and outputs a list of that many NumOrString objects, counting up
-- from 1 to the argument
-- e.g. "makeNumList 5" should produce:
-- [<NumOrString object with numeric 1>, <NumOrString object with
-- numeric 2>, <NumOrString object with numeric 3>, <NumOrString
-- object with numeric 4>, <NumOrString object with numeric 5>]
--
-- and where
-- map getNum <that list> should be [Just 1,Just 2,Just 3,Just 4,Just
-- 5]
--
-- to get the list in the right order, you may need to use Haskell's
-- append operator, which is ++
-- note the type signature of (++) is
-- (++) :: [a] -> [a] -> [a]

--makeNumList :: (Eq a, Num a) => a -> [NumOrString]
--makeNumList :: (Eq a, Num a, Num a1) => a -> a1
makeNumList :: Integer -> [NumOrString]
makeNumList 0 = []
makeNumList 1 = [Num 1]
makeNumList n = makeNumList (n - 1) ++ [Num n]






-- let's write bucket in Haskell
-- if you've already done it in Scheme, this shouldn't be too bad
-- if you haven't figured it out yet, here's another chance
-- remember how it works:
-- it takes a list of numbers and outputs a list of lists-of-numbers,
-- where like numbers are grouped together.
--
-- e.g. bucket [1,1,3,3,3,5,4,4] is
--             [[1,1],[3,3,3],[5],[4,4]]
--
-- use foldr (fold from the right)
-- think about the base case; in this example,
--   you're combining 4 and [] (and you should output [[4]])
-- then next you'll be combining 4 and [[4]]
--   and you should output [[4,4]]
-- then next you'll be combining 5 and [[4,4]]
--   and you should output [[5],[4,4]]
--
-- define the bucket op fcn first
-- name it bucket_op, and write its type signature



bucket_op :: Eq a => a -> [[a]] -> [[a]] -- here
bucket_op n l = if null l then [[n]] else if n == head (head l) then (n : head l) : tail l else [n] : l



  --l !! 0 !! 0

--if 20 == head (head l) then (20 : head l) : tail l else [20] : l
-- let l = [[1,2,3,4,5],[6,7,8,9,10],[11,12,13,14,15]]


-- now write the main bucket (which must use foldr and bucket_op)
-- and write its type signature

--bucket :: (Foldable a, Ord a1) => a a1 -> [[a1]]
bucket l = foldr bucket_op [] l

























fact 1 = 1
fact n = n * fact (n -1)






