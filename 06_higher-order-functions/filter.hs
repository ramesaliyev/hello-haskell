-- # http://learnyouahaskell.com/higher-order-functions#maps-and-filters

-- LOAD THIS FILE WITH ":l filter" within repl (ghci)
-- and reload with ":r"

-- Thanks to Haskell's laziness, even if you map something over a list
-- several times and filter it several times, it will only pass over the list once.

-- filter
-- takes a predicate (a predicate is a function that tells whether
-- something is true or not, so in our case, a function that returns
-- a boolean value) and a list and then returns the list of elements
-- that satisfy the predicate.

filter' :: (a -> Bool) -> [a] -> [a]
filter' _ [] = []
filter' p (x:xs)
    | p x       = x : filter p xs
    | otherwise = filter p xs

-- => filter (>3) [1,5,3,2,1,6,4,3,2,1]
-- ==> [5,6,4]
-- => filter even [1..10]
-- ==> [2,4,6,8,10]

notNullList = (let notNull x = not (null x)
  in filter notNull [[1,2,3],[],[3,4,5],[2,2],[],[],[]])

-- implementing quicksort with filter

quicksort' :: (Ord a) => [a] -> [a]
quicksort' [] = []
quicksort' (x:xs) =
    let smallerSorted = quicksort' (filter (<=x) xs)
        biggerSorted = quicksort' (filter (>x) xs)
    in  smallerSorted ++ [x] ++ biggerSorted

-- find the largest number under 100,000 that's divisible by 3829
largestDivisible :: (Integral a) => a
largestDivisible = head (filter p [100000,99999..])
    where p x = x `mod` 3829 == 0
-- That's laziness in action again. Because we only end up using the
-- head of the filtered list, it doesn't matter if the filtered list is
-- finite or infinite. The evaluation stops when the first adequate
-- solution is found.

-- filter doesn't work on infinite lists.
