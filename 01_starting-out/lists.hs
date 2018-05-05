-- # http://learnyouahaskell.com/starting-out#an-intro-to-lists
-- # http://learnyouahaskell.com/starting-out#texas-ranges
-- # http://learnyouahaskell.com/starting-out#im-a-list-comprehension

-- LOAD THIS FILE WITH ":l lists" within repl (ghci)
-- and reload with ":r"

--  In Haskell, lists are a homogenous data structure.
-- It stores several elements of the same type.
lostNumbers = [4, 8, 15, 16, 23, 42]

-- Putting two lists togehter.
-- ++ function takes two lists.
luckyNumbers = [3, 5, 7];
combinedList = lostNumbers ++ luckyNumbers

-- BTW: Strings are just lists of characters.
-- "hello" is just syntactic sugar for ['h','e','l','l','o'].
-- Because strings are lists, we can use list functions on them.
greeting = "hello" ++ " " ++ "world"
woot = ['w','o'] ++ ['o','t']

-- When you put together two lists, internally, Haskell has to walk
-- through the whole list on the left side of ++.
-- So this can make performance issue on long lists.
-- So using cons operator is better which useful for
-- putting something at the beginning of a list.
-- : function takes a element and a list.
smallCat = 'A':" SMALL CAT"
someNumbers = 5:[1,2,3,4]

-- ++ function takes two lists.
-- : function takes a element and a list.
-- [1,2,3] is actually just syntactic sugar for 1:2:3:[].
-- [] is an empty list.

-- If you want to get an element out of a list by index, use !!. The indices start at 0.
getFromList list index = list !! index
-- => getFromList smallCat 3

-- Lists can also contain lists.
-- The lists within a list can be of different lengths but they can't be of different types.
-- Just like you can't have a list that has some characters and some numbers,
-- you can't have a list that has some lists of characters and some lists of numbers.
mList = [[1], [1,2], [1,2,3], [1,2,3,4], [1,2,3,4,5]]

-- Lists can be compared if the stuff they contain can be compared.
-- When using <, <=, > and >= to compare lists, they are compared in lexicographical order.
-- First the heads are compared. If they are equal then the second elements are compared, etc.
areListsEqual a b = a == b
-- => areListsEqual (getFromList mList 2) (getFromList mList 3)
-- => areListsEqual (getFromList mList 3) (getFromList mList 3)
isSumOfListBigger a b = a > b
-- => isSumOfListBigger (getFromList mList 2) (getFromList mList 3)
-- => isSumOfListBigger (getFromList mList 3) (getFromList mList 2)
isListEmpty list = areListsEqual list []
-- Use null instead of this (list == [])

-- Some Lists Functions
-- > head [...] (returns first element)
-- > last [...] (returns last element)
-- > tail [...] (returns everything except first element)
-- > init [...] (returns everything except last element)
-- > length [...] (returns length of list)
-- > null [...] (returns True if list is empty, otherwise False) (Use null instead of list==[])
-- > reverse [...] (returns reversed list)
-- > take n [...] (returns a list which contains first n element of the list)
-- > drop n [...] (returns a list which doesnt contains first n element of the list)
-- > maximum [...] (returns the biggest element) (takes a list of stuff that can be put in some kind of order)
-- > minimum [...] (returns the smallest element) (takes a list of stuff that can be put in some kind of order)
-- > sum [...] (returns sum of numbers in the list)
-- > product [...] (returns product of numbers in the list)
-- > elem x [...] (returns True if list contains x) (Usually used as infix function => "1 `elem` []")

-- Ranges.
-- Lets make a list containing all the natural numbers from 1 to 20.
oneToTwenty = [1..20]
alphabet = ['a'..'z']

-- Ranges with step.
-- It's simply a matter of separating the first two elements with a comma
-- and then specifying what the upper limit is
evenNumbersToTwenty = [2, 4..20]

-- To make a list with all the numbers from 20 to 1,
-- you can't just do [20..1], you have to do [20,19..1].

-- Watch out when using floating point numbers in ranges!
-- Because they are not completely precise (by definition),
-- their use in ranges can yield some pretty funky results.

-- You can also use ranges to make infinite lists by just not specifying an upper limit.
-- For an example how you would get the first 24 multiples of 13?
-- One way to do this is;
first24MultiplesOf13 = [13, 26..24*13]
-- It starts from 13, 26 and goes to 24*13.
-- But better way is;
first24MultiplesOf13' = take 24 [13,26..]
-- This is an example of infinite lists.
-- Because Haskell is lazy, it won't try to evaluate the infinite list immediately because
-- it would never finish. It'll wait to see what you want to get out of that infinite lists.
-- And here it sees you just want the first 24 elements and it gladly obliges.

-- some lists of functions which produce infinite lists.
-- if you just try to display result of any of these functions;
-- it will go on forever so you have to slice it off somewhere.

-- > cycle [...] (takes a LIST and cycles (repeats list) it into an infinite list.)
-- => take 10 (cycle [1,2,3])
-- ==> [1,2,3,1,2,3,1,2,3,1]

-- > repeat x (takes an ELEMENT and produces an infinite list from repeating it.)
-- => take 10 (repeat 5)
-- ==> [5,5,5,5,5,5,5,5,5,5]
-- Although it's simpler to just use the replicate function if you want some number of the same element in a list.
-- => replicate 3 10
-- ==> [10, 10, 10]

-- List Comprehensions
-- For example we want to get first 10 even numbers.
first10EvenNumbersDoubled = [ x * 2 | x <- [1..10] ]
-- x is drawn from [1..10]
-- and for every element in [1..10] (which we have bound to x)
-- we get that element, only doubled.
-- ==> [2,4,6,8,10,12,14,16,18,20]
-- Now let's add a condition (or a predicate) to that comprehension.
-- Predicates go after the binding parts and are separated from them by a comma.
-- Let's say we want only the elements which, doubled, are greater than or equal to 12.
first10EvenNumbersDoubled' = [ x * 2 | x <- [1..10], x * 2 >= 12]
-- If we wanted all numbers from 50 to 100 whose remainder when divided with the number 7 is 3.
fiftyToHundredMod7Equal3 = [ x | x <- [50..100], x `mod` 7 == 3]

-- Weeding out lists by predicates is also called "filtering".

-- You can inclue several predicates.
-- If we wanted all numbers from 10 to 20 that are not 13, 15 or 19.
filterSomeNumbers = [ x | x <- [10..20], x /= 13, x /= 15, x /= 19]

-- We can also draw from several lists.
-- When drawing from several lists, comprehensions produce all combinations of the given lists
-- (by lazy cartesian multiplying way) and then join them by the output function we supply.
-- A list produced by a comprehension that draws from two lists of length 4 will have a length of 16,
-- provided we don't filter them. If we have two lists, [2,5,10] and [8,10,11] and we want to get the
-- products of all the possible combinations between numbers in those lists, here's what we'd do.
compTwoLists = [ x*y | x <- [2,5,10], y <- [8,10,11]]
-- If we wanted all possible products that are more than 50?
compTwoLists' = [ x*y | x <- [2,5,10], y <- [8,10,11], x*y > 50]

-- Example comprehension that combines a list of adjectives and a list of nouns.
nouns = ["hobo","frog","pope"]
adjectives = ["lazy","grouchy","scheming"]
nounsNAdjectives = [adjective ++ " " ++ noun | adjective <- adjectives, noun <- nouns]

-- Our own version of length.
length' list = sum [1 | _ <- list]
-- _ means that we don't care what we'll draw from the list

-- Because strings are lists, we can use list comprehensions to process and produce strings.
removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]

-- Nested list comprehensions are also possible if you're operating on lists that contain lists.
-- Let's remove all odd numbers without flattening the list.
multiNumberList = [[1,3,5,2,3,1,2,4,5], [1,2,3,4,5,6,7,8,9], [1,2,4,2,1,6,3,1,3,2,3,6]]
multiNumberList' = [ [ x | x <- xs, even x ] | xs <- xxs]
