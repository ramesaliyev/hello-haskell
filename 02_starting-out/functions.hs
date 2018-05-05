-- # http://learnyouahaskell.com/starting-out#babys-first-functions

-- LOAD THIS FILE WITH ":l functions" within repl (ghci)
-- and reload with ":r"

-- In Haskell functions are lazy!
-- Functions can't begin with uppercase letters.

-- This is a function declaration.
doubleMe x = x + x

-- You can call a function like this; (ignore declaration)
-- Those are function calls or "Function application" in haskell.
-- (calling a function by putting a space after it and then typing out the parameters)
callSucc num = succ num
-- => callSucc 5

-- If a function takes two parameters you can also call it as an infix function;
callMax x y = x `max` y
-- => callMax 3 5

-- Examples.

-- Common Haskel (Or FP) Pattern.
-- Make basic functions that are obviously correct and
-- then combining them into more complex functions
doubleUs x y = doubleMe x + doubleMe y
-- => doubleUs 3 5

-- Functions in Haskell don't have to be in any particular order,
-- so it doesn't matter if you define doubleMe first and then doubleUs
-- or if you do it the other way around.

-- If inside function.
doubleIfSmallThan100 x = if x >= 100 then x else x * 2

-- In Haskell every expression and function must return something.
-- So you cant ommit else. Else part is mandatory in Haskell.

-- Another thing about the if statement in Haskell is that it is an expression.
-- An expression is basically a piece of code that returns a value.

-- ' (apostrophe) is a valid character in functions (function names),
-- we can make a function like (doubleSmallNumber' ...).
-- We usually use ' to either denote a strict version of a function (one that isn't lazy)
-- or a slightly modified version of a function or a variable.
doubleIfSmallThan100' x = (if x >= 100 then x else x * 2) + 1

betterDoubleIfSmallThan100' x = succ (if x >= 100 then x else doubleMe x)

-- When a function doesn't take any parameters,
-- we usually say it's a definition (or a name).
conanO'Brien = "It's a-me, Conan O'Brien!"
