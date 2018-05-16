-- # http://learnyouahaskell.com/higher-order-functions#higher-orderism

-- LOAD THIS FILE WITH ":l higher-orderism" within repl (ghci)
-- and reload with ":r"

-- Functions can take functions as parameters and also return functions.

-- This functions takes a function and then applies it twice to something!
applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)
-- => applyTwice (+3) 10
-- ==> 16
-- => applyTwice (++ " HAHA") "HEY"
-- ==> "HEY HAHA HAHA"
-- => applyTwice ("HAHA " ++) "HEY"
-- ==> "HAHA HAHA HEY"
-- => applyTwice (3:) [1]
-- [3,3,1]

-- implementing zipWith
-- It takes a function and two lists as parameters and then joins the
-- two lists by applying the function between corresponding elements.
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys
-- => zipWith' (+) [4,2,5,6] [2,6,2,3]
-- ==> [6,8,7,9]
-- => zipWith (++) ["1", "2", "3"] ["a", "b", "c"]
-- ==> ["1a","2b","3c"]
-- => zipWith' (zipWith' (*)) [[1,2,3],[3,5,6],[2,3,4]] [[3,2,2],[3,4,5],[5,4,3]]
-- ==> [[3,4,6],[9,20,30],[10,12,12]]

-- implementing flip
-- It takes a function and returns a function that is like our original function,
-- only the first two arguments are flipped.
flip' :: (a -> b -> c) -> b -> a -> c
flip' f y x = f x y
-- => flip' zip [1,2,3,4,5] "hello"
-- ==> [('h',1),('e',2),('l',3),('l',4),('o',5)
-- => zipWith (flip' div) [2,2..] [10,8,6,4,2]
-- ==> [5,4,3,2,1]

-- first some words (from https://stackoverflow.com/questions/25589257/what-does-left-to-right-associativity-mean)

-- When we combine operators to form expressions, the order in which
-- the operators are to be applied may not be obvious. For example,
-- a + b + c can be interpreted as ((a + b) + c) or as (a + (b + c)).
-- We say that + is left-associative if operands are grouped left to
-- right as in ((a + b) + c). We say it is right-associative if it
-- groups operands in the opposite direction, as in (a + (b + c)).

--                                 A.V. Aho & J.D. Ullman 1977, p. 47

-- And;
-- left-associative is the same meaning of associating from left to right,
-- also the same meaning of left-to-right associativity.

-- for example:
-- a = (x * y) * z is left-to-right and a = x * (y * z) is right-to-left.

-- so keep those in mind;

-- From the type declarations;
-- "->"" is right associative by default.
-- (a -> b -> c) -> (b -> a -> c) is the same as
-- (a -> b -> c) -> (b -> (a -> c)), which is the same as
-- (a -> b -> c) -> b -> a -> c

-- This is why we can set type of flip as flip' :: (a -> b -> c) -> b -> a -> c

