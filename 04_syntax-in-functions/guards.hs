-- # http://learnyouahaskell.com/syntax-in-functions#guards-guards

-- LOAD THIS FILE WITH ":l guards" within repl (ghci)
-- and reload with ":r"

-- Guards are a way of testing whether some property of a value (or several of them) are true or false.

-- Note that there's no = right after the function name and its parameters, before the first guard.

bmiTell :: (RealFloat a) => a -> String
bmiTell bmi
    | bmi <= 18.5 = "You're underweight, you emo, you!"
    | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
    | bmi <= 30.0 = "You're fat! Lose some weight, fatty!"
    | otherwise   = "You're a whale, congratulations!"

-- otherwise is defined simply as otherwise = True and catches everything.

-- If all the guards of a function evaluate to False (and we haven't provided an otherwise catch-all guard),
-- evaluation falls through to the next pattern.

-- If no suitable guards or patterns are found, an error is thrown.

-- Let's modify this function so that it takes a height and weight and calculates BMI for us.
calcBmiTell :: (RealFloat a) => a -> a -> String
calcBmiTell weight height
    | weight / height ^ 2 <= 18.5 = "You're underweight, you emo, you!"
    | weight / height ^ 2 <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
    | weight / height ^ 2 <= 30.0 = "You're fat! Lose some weight, fatty!"
    | otherwise                 = "You're a whale, congratulations!"

-- Guards can also be written inline.
max' :: (Ord a) => a -> a -> a
max' a b | a > b = a | otherwise = b

-- Let's implement our own compare by using guards.
myCompare :: (Ord a) => a -> a -> Ordering
a `myCompare` b
    | a > b     = GT
    | a == b    = EQ
    | otherwise = LT
