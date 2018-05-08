-- # http://learnyouahaskell.com/recursion

-- LOAD THIS FILE WITH ":l basics" within repl (ghci)
-- and reload with ":r"

-- Recursion is actually a way of defining functions in which the function
-- is applied inside its own definition.

-- Having an element or two in a recursion definition defined non-recursively
-- is also called the edge condition

-- Recursion is important to Haskell because unlike imperative languages,
-- you do computations in Haskell by declaring what something is instead of
-- declaring how you get it. That's why there are no while loops or for loops
-- in Haskell and instead we many times have to use recursion to declare what something is.

-- Note that there's a pattern here. Usually you define an edge case and then
-- you define a function that does something between some element and the function applied to the rest.

-- implementing maximum
-- it takes a list of things that can be ordered and returns the biggest of them.

maximum' :: (Ord a) => [a] -> a
maximum' [] = error "maximum of empty list"
maximum' [x] = x
maximum' (x:xs)
    | x > maxTail = x
    | otherwise = maxTail
    where maxTail = maximum' xs

-- An even clearer way to write this function is to use max.
-- Max is a function that takes two numbers and returns the bigger of them.

maximum'2 :: (Ord a) => [a] -> a
maximum'2 [] = error "maximum of empty list"
maximum'2 [x] = x
maximum'2 (x:xs) = max x (maximum' xs)

-- implementing replicate
-- it takes an Int and some element and returns a list that has several repetitions of the same element.

replicate' :: (Num i, Ord i) => i -> a -> [a]
replicate' n x
    | n <= 0    = []
    | otherwise = x:replicate' (n-1) x

-- implementing take
-- It takes a certain number of elements from a list.

take' :: (Num i, Ord i) => i -> [a] -> [a]
take' n _
    | n <= 0   = []
take' _ []     = []
take' n (x:xs) = x : take' (n-1) xs

-- implementing reverse
-- it simply reverses a list.

reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x]

-- implementing repeat
-- takes an element and returns an infinite list that just has that element.

repeat' :: a -> [a]
repeat' x = x:repeat' x
-- not fully understand how lists generated here
-- seems like : creating list on the lfy?

-- implementing zip
-- it takes two lists and zips them together.

zip' :: [a] -> [b] -> [(a,b)]
zip' _ [] = []
zip' [] _ = []
zip' (x:xs) (y:ys) = (x,y):zip' xs ys

-- implementing elem
-- It takes an element and a list and sees if that element is in the list.

elem' :: (Eq a) => a -> [a] -> Bool
elem' a [] = False
elem' a (x:xs)
    | a == x    = True
    | otherwise = a `elem'` xs
