-- # http://learnyouahaskell.com/higher-order-functions#folds

-- LOAD THIS FILE WITH ":l fold" within repl (ghci)
-- and reload with ":r"

-- fold functions  reduce the list to some single value.

-- A fold takes a binary function, a starting value (I like to call it the accumulator)
-- and a list to fold up. The binary function itself takes two parameters.
-- The binary function is called with the accumulator and the first (or last)
-- element and produces a new accumulator. Then, the binary function is called again
-- with the new accumulator and the now new first (or last) element, and so on.
-- Once we've walked over the whole list, only the accumulator remains,
-- which is what we've reduced the list to.

-- foldl
-- left fold
-- It folds the list up from the left side.
-- It start with starting value as accumulator and head of list as first value.
-- function has the accumulator as the first parameter and the current value as the second one.
-- (\acc x -> ...)

sum' :: (Num a) => [a] -> a
sum' xs = foldl (\acc x -> acc + x) 0 xs

sum'2 :: (Num a) => [a] -> a
sum'2 = foldl (+) 0

elem' :: (Eq a) => a -> [a] -> Bool
elem' y ys = foldl (\acc x -> if x == y then True else acc) False ys

-- foldr
-- right fold
-- It folds the list up from the right side.
-- It start with starting value as accumulator and last elem of list as first value.
-- function has the current value as the first parameter and the accumulator as the second one.
-- (\x acc -> ...)

map' :: (a -> b) -> [a] -> [b]
map' f xs = foldr (\x acc -> f x : acc) [] xs

-- IMPORTANT! we could have implemented this function with a left fold.
-- but the ++ function is much more expensive than :
-- so we usually use right folds when we're building up new lists from a list.

mapl :: (a -> b) -> [a] -> [b]
mapl f xs = foldl (\acc x -> acc ++ [f x]) [] xs

-- One big difference is that right folds work on infinite lists, whereas left ones don't!
-- Because you can reach to the beginning of infinite list from some point of it,
-- but you'll never reach an end from some point of it.

-- Folds are, along with maps and filters, one of the most useful types of functions in functional programming.

-- foldl1 foldr1
-- The foldl1 and foldr1 functions work much like foldl and foldr,
-- only you don't need to provide them with an explicit starting value.
-- They assume the first (or last) element of the list to be the
-- starting value and then start the fold with the element next to it.

betterSum :: [Int] -> Int
betterSum = foldl1 (+)

-- foldl and foldr work fine with empty lists but foldl1 and foldr1 wont because
-- they depend on the lists they fold up having at least one element.
-- This can cause runtime errors!

-- some examples

maximum' :: (Ord a) => [a] -> a
maximum' = foldr1 (\x acc -> if x > acc then x else acc)

reverse' :: [a] -> [a]
reverse' = foldl (flip (:)) []
-- reverse' = foldl (\acc x -> x : acc) []

product' :: (Num a) => [a] -> a
product' = foldr1 (*)

filter' :: (a -> Bool) -> [a] -> [a]
filter' p = foldr (\x acc -> if p x then x : acc else acc) []

head' :: [a] -> a
head' = foldr1 (\x _ -> x)

last' :: [a] -> a
last' = foldl1 (\_ x -> x)

