-- # http://learnyouahaskell.com/higher-order-functions#folds

-- LOAD THIS FILE WITH ":l scan" within repl (ghci)
-- and reload with ":r"

-- scanl and scanr are like foldl and foldr, only they report all the
-- intermediate accumulator states in the form of a list.
-- There are also scanl1 and scanr1, which are analogous to foldl1 and foldr1.

scanSum = scanl (+) 0 [1,2,3,4,5,6]

-- Scans are used to monitor the progression of a function that can be implemented as a fold.

-- How many elements does it take for the sum of the roots of all natural numbers to exceed 1000?
sqrtSums :: Int
sqrtSums = length (takeWhile (<1000) (scanl1 (+) (map sqrt [1..]))) + 1
