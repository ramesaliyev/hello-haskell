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

