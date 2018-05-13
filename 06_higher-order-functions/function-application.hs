-- # http://learnyouahaskell.com/higher-order-functions#function-application

-- LOAD THIS FILE WITH ":l function-application" within repl (ghci)
-- and reload with ":r"

-- $ function, also called function application.

-- definition
-- ($) :: (a -> b) -> a -> b
-- f $ x = f x

-- Whereas normal function application (putting a space between two things) has
-- a really high precedence, the $ function has the lowest precedence.

-- Function application with a space is left-associative
-- (so f a b c is the same as ((f a) b) c)),
-- function application with $ is right-associative.
-- (so f $ a $ b c is the same as (f (a (b c))),

-- Most of the time, it's a convenience function
-- so that we don't have to write so many parentheses.

one = sum (map sqrt [1..130])
two = sum $ map sqrt [1..130]

-- When a $ is encountered, the expression on its right is applied
-- as the parameter to the function on its left.

-- the; sqrt 3 + 4 + 9
-- is same as; (sqrt 3) + 4 + 9

-- but the sqrt $ 3 + 4 + 9
-- is same as; sqrt (3 + 4 + 9)

-- Again, $ has the lowest precedence of any operator.

-- $ being sort of the equivalent of writing an opening parentheses and
-- then writing a closing one on the far right side of the expression.

one' = sum (filter (> 10) (map (*2) [2..10]))
two' = sum $ filter (> 10) $ map (*2) [2..10]

-- Apart from getting rid of parentheses, $ means that function application can
-- be treated just like another function. That way, we can, for instance,
-- map function application over a list of functions.

mapOverFns = map ($ 3) [(4+), (10*), (^2), sqrt]
-- ==> [7.0, 30.0, 9.0, 1.7320508075688772]

