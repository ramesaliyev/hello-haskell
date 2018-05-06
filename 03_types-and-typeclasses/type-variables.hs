-- # http://learnyouahaskell.com/types-and-typeclasses#type-variables

-- LOAD THIS FILE WITH ":l type-variables" within repl (ghci)
-- and reload with ":r"

-- Types are written in capital case.
-- But type variables are write in lower case.

-- Type variables are like Generics in other languages.
-- But more  powerful because it allows us to easily write very general functions
-- if they don't use any specific behavior of the types in them.

-- Functions that have type variables are called polymorphic functions.

-- Type variables can have names longer than one character,
-- but we usually give them names of a, b, c, d.

-- For example getFirstOfList takes an list of type a, and returns a value of type a.
-- The "a" is the type variable in type definition.
getFirstOfList :: [a] -> a
getFirstOfList list = list !! 0

-- For example fst takes a tuple and returns first element of tuple.
-- => :t fst
-- ==> fst :: (a, b) -> a
-- Because a and b is type variables that taken tuple have and a is the type what it returns.
-- a and b dont have to be different types.
-- It just states that the first component's type and the return value's type are the same.

