-- # http://learnyouahaskell.com/syntax-in-functions#case-expressions

-- LOAD THIS FILE WITH ":l case" within repl (ghci)
-- and reload with ":r"

-- Case's are expressions in haskell.
-- So they return a value.
-- Much like if else expressions and let bindings.

-- Not only can we evaluate expressions based on the possible cases of the value of a variable
-- We can also do pattern matching with case's.

-- Pattern matching on parameters in function definitions are
-- actually just syntactic sugar for case expressions.

head' :: [a] -> a
head' [] = error "No head for empty lists!"
head' (x:_) = x

headSame' :: [a] -> a
headSame' xs = case xs of [] -> error "No head for empty lists!"
                          (x:_) -> x
{--
Syntax:

case expression of pattern -> result
                   pattern -> result
                   pattern -> result
                   ...
--}

-- The first pattern that matches the expression is used.
-- If it falls through the whole case expression and no suitable pattern is found,
-- a runtime error occurs.

-- Whereas pattern matching on function parameters can only be done when defining functions,
-- case expressions can be used pretty much anywhere. For instance:

describeList :: [a] -> String
describeList xs = "The list is " ++ case xs of [] -> "empty."
                                               [x] -> "a singleton list."
                                               xs -> "a longer list."

--- BTW we could have also defined this like;

describeList' :: [a] -> String
describeList' xs = "The list is " ++ what xs
    where what [] = "empty."
          what [x] = "a singleton list."
          what xs = "a longer list."
