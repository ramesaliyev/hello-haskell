-- # http://learnyouahaskell.com/higher-order-functions#maps-and-filters

-- LOAD THIS FILE WITH ":l collatz-sequences" within repl (ghci)
-- and reload with ":r"

-- Collatz sequences

-- We take a natural number.
-- If that number is even, we divide it by two.
-- If it's odd, we multiply it by 3 and then add 1 to that.
-- We take the resulting number and apply the same thing to it,
-- which produces a new number and so on.
-- In essence, we get a chain of numbers.
-- It is thought that for all starting numbers, the chains finish at the number 1.

-- Now what we want to know is this:
-- for all starting numbers between 1 and 100,
-- how many chains have a length greater than 15?

-- First off, we'll write a function that produces a chain:

chain :: (Integral a) => a -> [a]
chain 1 = [1]
chain n
    | even n =  n:chain (n `div` 2)
    | odd n  =  n:chain (n*3 + 1)

-- => chain 10
-- ==> [10,5,16,8,4,2,1]

-- And now, the function that tells us the answer to our question:

numLongChains :: Int
numLongChains = length (filter isLong (map chain [1..100]))
    where isLong xs = length xs > 15

-- We can also implement this with lambdas.

numLongChains' :: Int
numLongChains' = length (filter (\xs -> length xs > 15) (map chain [1..100]))
