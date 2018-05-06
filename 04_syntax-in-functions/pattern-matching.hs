-- # http://learnyouahaskell.com/syntax-in-functions#pattern-matching

-- LOAD THIS FILE WITH ":l pattern-matching" within repl (ghci)
-- and reload with ":r"

-- Pattern matching consists of specifying patterns to which some data should
-- conform and then checking to see if it does and deconstructing the data
-- according to those patterns.

lucky :: (Integral a) => a -> String
lucky 7 = "LUCKY NUMBER SEVEN!"
lucky x = "Sorry, you're out of luck, pal!"

-- When you call lucky, the patterns will be checked from top to bottom and when
-- it conforms to a pattern, the corresponding function body will be used.

factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial n = n * factorial (n - 1)

-- When making patterns, we should always include a catch-all pattern
-- so that our program doesn't crash if we get some unexpected input.

-- Pattern matching can also be used on tuples.
addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)
addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

-- Extract components of triple tuples.
first :: (a, b, c) -> a
first (x, _, _) = x

second :: (a, b, c) -> b
second (_, y, _) = y

third :: (a, b, c) -> c
third (_, _, z) = z

-- The _ means the same thing as it does in list comprehensions.
-- It means that we really don't care what that part is, so we just write a _.

-- You can also pattern match in list comprehensions.
tuples = [(1,3), (4,3), (2,4), (5,3), (5,6), (3,1)]
sumOfTuples = [ a + b | (a, b) <- tuples ]
-- Should a pattern match fail, it will just move on to the next element.

-- Lists themselves can also be used in pattern matching.

-- If you want to bind, say, the first three elements to variables and the rest
-- of the list to another variable, you can use something like x:y:z:zs.
-- It will only match against lists that have three elements or more.

-- x:xs will bind the head of the list to x and the rest of it to xs.
-- Note: The x:xs pattern is used a lot, especially with recursive functions.
-- But patterns that have : in them only match against lists of length 1 or more.

-- You can match with the empty list []
-- [x]
-- or any pattern that involves : and the empty list.
-- x:[]

head' :: [a] -> a
head' [] = error "Can't call head on an empty list, dummy!"
head' (x:_) = x

tell :: (Show a) => [a] -> String
tell [] = "The list is empty"
tell (x:[]) = "The list has one element: " ++ show x
tell (x:y:[]) = "The list has two elements: " ++ show x ++ " and " ++ show y
tell (x:y:_) = "This list is long. The first two elements are: " ++ show x ++ " and " ++ show y

-- Note that (x:[]) and (x:y:[]) could be rewriten as [x] and [x,y]
-- Because [x] is a syntatic sugar for x:[]
-- And [x,y] is for x:y:[]
-- We can use syntatic sugar and omit the () parentheses.
-- We can't rewrite (x:y:_) with square brackets because it matches any list of length 2 or more.

-- Length function with pattern matching and a recursion.
length' :: (Num b) => [a] -> b
length' [] = 0 -- this kind of stuffs also known as edge condition.
length' (_:xs) = 1 + length' xs

-- Sum function with pattern matching and a recursion.
sum' :: (Num a) => [a] -> a
sum' [] = 0
sum' (x:xs) = x + sum' xs

-- Patterns
-- Those are a handy way of breaking something up according to a pattern and
-- binding it to names whilst still keeping a reference to the whole thing.

-- You do that by putting a name and an @ in front of a pattern. For instance, the pattern xs@(x:y:ys).
-- This pattern will match exactly the same thing as x:y:ys but you can easily get the whole list via xs
-- instead of repeating yourself by typing out x:y:ys in the function body again.

capital :: String -> String
capital "" = "Empty string, whoops!"
capital all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x]

-- You can't use ++ in pattern matches.



