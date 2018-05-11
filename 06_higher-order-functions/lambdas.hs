-- # http://learnyouahaskell.com/higher-order-functions#lambdas

-- LOAD THIS FILE WITH ":l lambdas" within repl (ghci)
-- and reload with ":r"

-- Lambdas are basically anonymous functions that are used because we need some functions only once.
-- We usually surround them by parentheses, because otherwise they extend all the way to the right.

-- Lambdas are expressions.

-- (\xs -> length xs > 15)

-- Lambdas can take any number of parameters.

wut = zipWith (\a b -> (a * 30 + 3) / b) [5,4,3,2,1] [1,2,3,4,5]

-- Dont use lambdas where you don't need to!
-- For example, followings are same (thanks to currying).
-- => map (+3) [1,6,3,2]
-- => map (\x -> x + 3) [1,6,3,2]
-- But making a lambda in this case is stupid,
-- since using partial application is much more readable.

-- You can pattern match in lambdas.
-- The only difference is that you can't define several patterns for one parameter.

theMap = map (\(a,b) -> a + b) [(1,2),(3,5),(6,3),(2,6),(2,5)]

-- Lambdas are normally surrounded by parentheses unless we mean for them to
-- extend all the way to the right.
-- Due to the way functions are curried by default, these two are equivalent:
addThree :: (Num a) => a -> a -> a -> a
addThree x y z = x + y + z

addThree' :: (Num a) => a -> a -> a -> a
addThree' = \x -> \y -> \z -> x + y + z -- But this is stupid of course.
