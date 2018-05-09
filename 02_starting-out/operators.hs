-- # http://learnyouahaskell.com/starting-out#ready-set-go

-- LOAD THIS FILE WITH ":l operators" within repl (ghci)
-- and reload with ":r"

-- Pretty much all operators are functions in Haskell.
-- You can use them infix mode by default.
-- If a function is comprised only of special characters, it's considered an infix function by default.
-- But when you want to pass it to another function or call it as a prefix function,
-- you have to surround it in parentheses

sumTwo a b = (+) a b
isEqual a b = (==) a b

isNotEqual a b = not (isEqual a b)

isNotEqual' a b = a /= b

isNotEqual'2 a b = (/=) a b
