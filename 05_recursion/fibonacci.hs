-- # not from book

-- LOAD THIS FILE WITH ":l fibonacci" within repl (ghci)
-- and reload with ":r"

-- implementing fibonacci sequences in haskell
-- this is the list of fibonacci numbers going to infiite.

fibs :: [Integer]
fibs = 1 : 1 : zipWith (+) fibs (tail fibs)

{--

  [(1), 1, x, ...] [(1), x...] | x = 2
  [1, (1), 2, y, ...] [1, (2), y...] | y = 3
  [1, 1, (2), 3, z, ...] [1, 2, (3), z, ...] | z = 5

  ...going forever

--}
