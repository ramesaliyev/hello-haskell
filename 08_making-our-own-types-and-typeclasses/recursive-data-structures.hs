-- # http://learnyouahaskell.com/making-our-own-types-and-typeclasses#recursive-data-structures

-- LOAD THIS FILE WITH ":l recursive-data-structures" within repl (ghci)
-- and reload with ":r"

-- As we've seen, a constructor in an algebraic data type can have several
-- (or none at all) fields and each field must be of some concrete type.
-- With that in mind, we can make types whose constructors have fields that
-- are of the same type! Using that, we can create recursive data types, where
-- one value of some type contains values of that type, which in turn contain
-- more values of the same type and so on.

-- Our recursive List definition.

data List a = Empty | Cons a (List a) deriving (Show, Read, Eq, Ord)

-- Cons doesnt have any special meaning, its only short name for Constructor
-- So it is just an arbitrary name which is also historic.
-- I guess people used it for ':' in lists. Its not important.

-- Look answers in https://stackoverflow.com/a/41559202/1294887

emptyList = Empty

-- => :t emptyList
-- ==> Empty :: List a -- So this is an empty list!

-- => Empty
-- ==> Empty

list = Cons 5 Empty -- list with 5 init.

-- We can use it as infix!

anotherList =  3 `Cons` (4 `Cons` (5 `Cons` Empty))
-- ==> Cons 3 (Cons 4 (Cons 5 Empty))

-- 4 `Cons` (5 `Cons` Empty) is like 4:(5:[]).

-- So get this correct;
-- "Cons" is a value constructor!
-- And it takes two things;
-- 1) a value in type "a"
-- 2) a value in type "List a"
--   So...
--   What "List a" can be?
--   It can be "Empty" or "Cons"
--   So if it is a "Empty", then ok. End of line.
--   But if it is a "Cons" THIS IS WHERE RECURSION BEGINS!

-- We can define functions to be automatically infix by making them
-- comprised of only special characters. We can also do the same with
-- constructors, since they're just functions that return a data type.

infixr 5 :-:
data List' a = Empty' | a :-: (List' a) deriving (Show, Read, Eq, Ord)

-- so :-: just another historic symbol for "Constructor" and here
-- we are using it to replace previous "Cons". But since it created with
-- only special characters we can use it infix by default.
-- and infixr give its precedence. as 5.

-- Notice a new syntactic construct, the fixity declarations.
-- When we define functions as operators, we can use that to give them
-- a fixity (but we don't have to).

-- A fixity states how tightly the operator binds and whether it's
-- left-associative or right-associative.

-- Operator that has a greater fixity bind tighter.
-- This means its gonna be first applied.
-- Like multiply operator in this example: 5 + 3 * 2

betterList = 3 :-: 4 :-: 5 :-: Empty'

-- => betterList
-- ==> 3 :-: (4 :-: (5 :-: Empty'))

-- Let's make a function that adds two of our lists together.
-- We stole this from original ++ definition (which works with normal lists)

infixr 5  .++
(.++) :: List' a -> List' a -> List' a
Empty' .++ ys = ys
(x :-: xs) .++ ys = x :-: (xs .++ ys)

-- That works because pattern matching is actually about matching constructors.
-- We can match on :-: because it is a constructor for our own list type and we
-- can also match on : because it is a constructor for the built-in list type.
-- Same goes for [].

listA = 3 :-: 4 :-: 5 :-: Empty'
listB = 6 :-: 7 :-: Empty'

listAConcatB = listA .++ listB

-- => listAConcatB
-- ==> 3 :-: (4 :-: (5 :-: (6 :-: (7 :-: Empty'))))

