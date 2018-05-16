-- # http://learnyouahaskell.com/modules#data-list

-- LOAD THIS FILE WITH ":l module-data-function" within repl (ghci)
-- and reload with ":r"

import Data.List
import Data.Function -- this is our boy

-- > on

-- signature;
-- on :: (b -> b -> c) -> (a -> b) -> a -> a -> c
-- f `on` g = \x y -> f (g x) (g y)

-- example;
-- (==) `on` (> 0)
-- equals to
-- \x y -> (x > 0) == (y > 0)
groupByAdjacentSign = groupBy ((==) `on` (> 0))
-- => groupByAdjacentSign [1,-2,-3,4,5,-6,7,8,-9,-10]
-- ==> [[1],[-2,-3],[4,5],[-6],[7,8],[-9,-10]]

-- example 2;
-- compare `on` length
-- equals to
-- \x y -> length x `compare` length y
sortListsByLength :: [[a]] -> [[a]]
sortListsByLength = sortBy (compare `on` length)
-- => sortListsByLength [[1,2,3,4], [1,2], [1], [1,2,3]]

-- NOTE: When you're dealing with By functions that take an equality function,
-- you usually do (==) `on` something and when you're dealing with By functions
-- that take an ordering function, you usually do compare `on` something.
