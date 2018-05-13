-- # http://learnyouahaskell.com/modules#data-list

-- LOAD THIS FILE WITH ":l module-data-list" within repl (ghci)
-- and reload with ":r"

-- Data.List module provides some very useful functions for dealing with lists.

-- Because the Prelude module exports some functions from Data.List,
-- we've already met some of its functions like map and filter.

-- We don't have to import Data.List via a qualified import because it doesn't
-- clash with any Prelude names. (Except for those that Prelude already steals from Data.List)

import Data.List

-- > intersperse
-- takes an element and a list and then puts that element in between
-- each pair of elements in the list.
example_1 = intersperse '.' "MONKEY"
-- ==> "M.O.N.K.E.Y"

-- > intercalate
-- takes a list of lists and a list. It then inserts that list in between all
-- those lists and then flattens the result.
example_2 = intercalate " " ["hey","there","guys"]
-- ==> "hey there guys"
example_3 = intercalate [0,0,0] [[1,2,3],[4,5,6],[7,8,9]]
-- ==> [1,2,3,0,0,0,4,5,6,0,0,0,7,8,9]

-- > transpose
-- transposes a list of lists. If you look at a list of lists as a 2D matrix,
-- the columns become the rows and vice versa.
example_4 = transpose [[1,2,3], [4,5,6], [7,8,9]]
-- ==> [[1,4,7], [2,5,8], [3,6,9]]

-- Say we have the polynomials 3x2 + 5x + 9, 10x3 + 9 and 8x3 + 5x2 + x - 1 and
-- we want to add them together. We can use the lists [0,3,5,9], [10,0,0,9] and
-- [8,5,1,-1] to represent them in Haskell. Now, to add them, all we have to do is this:
sumOfPolynomials = map sum $ transpose [[0,3,5,9],[10,0,0,9],[8,5,1,-1]]

-- foldl' and foldl1'
-- these are stricter versions of their respective lazy incarnations.
-- When using lazy folds on really big lists, you might often get a stack overflow error.
-- Due to the lazy nature of the folds, the accumulator value isn't actually
-- updated as the folding happens. What actually happens is that the accumulator
-- kind of makes a promise that it will compute its value when asked to actually
-- produce the result (also called a thunk). That happens for every intermediate
-- accumulator and all those thunks overflow your stack. The strict folds aren't
-- lazy buggers and actually compute the intermediate values as they go along
-- instead of filling up your stack with thunks. So if you ever get stack overflow
-- errors when doing lazy folds, try switching to their strict versions.

-- > concat
-- flattens a list of lists into just a list of elements.
example_5 = concat [[1,2,3], [4,5,6], [7,8,9]]
-- ==> [1,2,3,4,5,6,7,8,9]

-- > concatMap
-- the same as first mapping a function to a list and then concatenating the list with concat.
example_6 = concatMap (replicate 4) [1..3]
-- ==> [1,1,1,1,2,2,2,2,3,3,3,3]

-- > and
-- takes a list of boolean values and returns True only if all the values in the list are True
example_7 = and $ map (>4) [5,6,7,8]
-- => True

-- > or
-- takes a list of boolean values and returns True if any the values in the list are True
example_8 = or $ map (>7) [5,6,7,8]
-- => True

-- > any & all
-- these functions take a predicate and then check if any or all the elements in
-- a list satisfy the predicate, respectively. Usually we use these two functions
-- instead of mapping over a list and then doing and or or.
example_9 = any (==4) [2,3,5,6,1,4]
-- ==> True
example_10 = all (>4) [3, 6,9,10]
-- ==> False

-- > iterate
-- takes a function and a starting value. It applies the function to the starting value,
-- then it applies that function to the result, then it applies the function to that result again, etc.
example_11 = take 10 $ iterate (*2) 1
-- ==> [1,2,4,8,16,32,64,128,256,512]

-- > splitAt
-- takes a number and a list. It then splits the list at that many elements,
-- returning the resulting two lists in a tuple.
example_12 = splitAt 3 "heyman"
-- ==> ("hey","man")
example_13 = let (a,b) = splitAt 3 "foobar" in b ++ a
-- ==> "barfoo"

-- > takeWhile
-- It takes elements from a list while the predicate holds and
-- then when an element is encountered that doesn't satisfy the predicate, it's cut off.
example_14 = takeWhile (>3) [6,5,4,3,2,1,2,3,4,5,4,3,2,1]
-- ==> [6,5,4]

-- > dropWhile
-- It drops all the elements while the predicate is true.
-- Once predicate equates to False, it returns the rest of the list.
example_15 = dropWhile (<3) [1,2,2,2,3,4,5,4,3,2,1]
-- ==> [3,4,5,4,3,2,1]


