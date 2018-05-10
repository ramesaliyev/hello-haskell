-- # http://learnyouahaskell.com/higher-order-functions#maps-and-filters

-- LOAD THIS FILE WITH ":l takewhile" within repl (ghci)
-- and reload with ":r"

-- Thanks to Haskell's laziness, even if you map something over a list
-- several times and filter it several times, it will only pass over the list once.

-- takeWhile
-- It takes a predicate and a list and then goes from the beginning
-- of the list and returns its elements while the predicate holds true.
-- Once an element is found for which the predicate doesn't hold, it stops.

firstWord :: String -> String
firstWord = takeWhile (/=' ')

-- => firstWord "elephants know how to party"
-- ==> "elephants"

-- find the sum of all odd squares that are smaller than 10,000
-- First, we'll begin by mapping the (^2) function to the infinite list [1..].
-- Then we filter them so we only get the odd ones.
-- And then, we'll take elements from that list while they are smaller than 10,000.
-- Finally, we'll get the sum of that list.

sumOf = sum (takeWhile (<10000) (filter odd (map (^2) [1..])))

-- same with list comprehensions

sumOfWLC = sum (takeWhile (<10000) [n^2 | n <- [1..], odd (n^2)])

-- Haskell's property of laziness is what makes this possible.
-- Only when we force Haskell to show us the sum does the sum
-- function say to the takeWhile that it needs those numbers.
-- takeWhile forces the filtering and mapping to occur,
-- but only until a number greater than or equal to 10,000 is encountered.
