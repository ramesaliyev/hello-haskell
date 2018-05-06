-- # http://learnyouahaskell.com/syntax-in-functions#where

-- LOAD THIS FILE WITH ":l where" within repl (ghci)
-- and reload with ":r"

-- Where

-- Above we repeated ourselves three times when calculating BMI.
-- It would be ideal if we could calculate it once,
-- bind it to a name and then use that name instead of the expression.

calcBmiTell' :: (RealFloat a) => a -> a -> String
calcBmiTell' weight height
    | bmi <= 18.5 = "You're underweight, you emo, you!"
    | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
    | bmi <= 30.0 = "You're fat! Lose some weight, fatty!"
    | otherwise   = "You're a whale, congratulations!"
    where bmi = weight / height ^ 2

-- Lets go further!

betterBmiTell :: (RealFloat a) => a -> a -> String
betterBmiTell weight height
    | bmi <= skinny = "You're underweight, you emo, you!"
    | bmi <= normal = "You're supposedly normal. Pffft, I bet you're ugly!"
    | bmi <= fat    = "You're fat! Lose some weight, fatty!"
    | otherwise     = "You're a whale, congratulations!"
    where bmi = weight / height ^ 2
          skinny = 18.5
          normal = 25.0
          fat = 30.0

-- The names we define in the where section of a function are only visible to that function.
-- where bindings aren't shared across function bodies of different patterns.

-- Notice that all the names are aligned at a single column.
-- If we don't align them nice and proper, Haskell gets confused because
-- then it doesn't know they're all part of the same block.

-- You can also use where bindings to pattern match.

-- Get a first and a last name and give someone back their initials.
initials :: String -> String -> String
initials firstname lastname = [f] ++ ". " ++ [l] ++ "."
    where (f:_) = firstname
          (l:_) = lastname
-- We could have done this pattern matching directly in the function's parameters
-- (it would have been shorter and clearer actually) but this just goes to show
-- that it's possible to do it in where bindings as well.

-- You can also define functions.

-- Lets take a list of weight-height pairs and return a list of BMIs.
calcBmis :: (RealFloat a) => [(a, a)] -> [a]
calcBmis xs = [bmi w h | (w, h) <- xs]
    where bmi weight height = weight / height ^ 2

-- where bindings can also be nested.
-- It's a common idiom to make a function
-- and define some helper function in its where clause
-- and then to give those functions helper functions as well,
-- each with its own where clause.

doublePlusOne x = plusOne x
  where plusOne x = double x + 1
          where double x = x * 2
