-- # http://learnyouahaskell.com/recursion#quick-sort

-- LOAD THIS FILE WITH ":l quicksort" within repl (ghci)
-- and reload with ":r"

-- implementing quicksort in haskell

quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =
    let smallerSorted = quicksort [a | a <- xs, a <= x]
        biggerSorted = quicksort [a | a <- xs, a > x]
    in  smallerSorted ++ [x] ++ biggerSorted

-- So if we have, say [5,1,9,4,6,7,3] and we want to sort it, this algorithm
-- will first take the head, which is 5 and then put it in the middle of two
-- lists that are smaller and bigger than it. So at one point, you'll have
-- [1,4,3] ++ [5] ++ [9,6,7]. We know that once the list is sorted completely,
-- the number 5 will stay in the fourth place since there are 3 numbers lower
-- than it and 3 numbers higher than it. Now, if we sort [1,4,3] and [9,6,7],
-- we have a sorted list! We sort the two lists using the same function.
-- Eventually, we'll break it up so much that we reach empty lists and an
-- empty list is already sorted in a way, by virtue of being empty.
