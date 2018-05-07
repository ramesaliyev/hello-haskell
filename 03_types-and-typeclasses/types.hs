-- # http://learnyouahaskell.com/types-and-typeclasses#believe-the-type

-- LOAD THIS FILE WITH ":l types" within repl (ghci)
-- and reload with ":r"

-- Haskell has a static type system.
-- Haskell has type inference.

-- You can use GHCI to examine the types of an expressions.
-- You can also check type of functions with :t because Functions are expressions too.
-- You can also write a function without type and then check which type it gain by compiler with :t
-- for example;
-- => sumTwo x y = x + y
-- => :t sumTwo
-- ==> sumTwo :: Num a => a -> a -> a

-- Explicit types are always denoted with the first letter in capital case. Like "Char".

-- Functions also have types. When writing our own functions,
-- we can choose to give them an explicit type declaration.

-- Takes Int returns Int
doubleMe :: Int -> Int
doubleMe x = x * 2

-- Takes String returns String
removeNonUppercase :: String -> String
-- or removeNonUppercase :: [Char] -> [Char]
removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]

-- Takes two Int and returns Int
sumTwo :: Int -> Int -> Int -- last one is return type
sumTwo x y = x + y

-- Takes tuple of two int and return first
getFirstVector :: (Int, Int) -> Int
getFirstVector tuple = fst tuple

-- Some Types
-- > Int (Bounded integer. Between -2147483648 and 2147483647.)
-- > Integer (Not bounded integer. It can represent really big numbers.)
-- > Float (Real floating point with single precision.)
-- > Double (Real floating point with double the precision!)
-- > Bool (True or False)
-- > Char (A character. Denoted by single quotes.)
-- > String (A list of characters. Donated by double quotes.)
-- > Tuples are types but they are dependent on their length as well as the types of their components
-- > Empty tuple () is also a type which can only have a single value: ()
