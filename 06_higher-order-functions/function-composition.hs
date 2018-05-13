-- # http://learnyouahaskell.com/higher-order-functions#composition

-- LOAD THIS FILE WITH ":l function-composition" within repl (ghci)
-- and reload with ":r"

-- Function composition is pretty much the same thing with mathematics.
-- Function composition is right-associative.

-- In mathematics, function composition is defined like this:
-- (fog)(x) = f(g(x))

-- In Haskell, we do function composition with the . function.
-- definition:
-- (.) :: (b -> c) -> (a -> b) -> a -> c
-- f . g = \x -> f (g x)

-- Mind the type declaration.
-- f must take as its parameter a value that has the same type as g's return value.
-- So the resulting function takes a parameter of the same type that g takes and
-- returns a value of the same type that f returns.

-- these are same;
multiply3Negate x = negate $ x * 3
multiply3Negate' = negate . (* 3)

-- One of the uses for function composition is making functions on the fly to pass to other functions.
-- Many times, function composition is clearer and more concise than lambdas.

-- these are same;
toNegative = map (\x -> negate (abs x))
toNegative' = map (negate . abs)

-- Function composition is right-associative, so we can compose many functions at a time.
-- The expression f (g (z x)) is equivalent to (f . g . z) x.

-- these are same;
same = map (\xs -> negate (sum (tail xs)))
same' = map (negate . sum . tail)

-- If we want to use functions that take several parameters in function composition,
-- we usually have to partially apply them just so much that each function takes just one parameter.

-- we can write this;
sum'1 = sum (replicate 5 (max 6 7))
-- like that;
sum'2 = sum . replicate 5 . max 6 $ 8
-- notice that replicate and max functions are partially applied.

-- these are same;
one = replicate 100 (product (map (*3) (zipWith max [1,2,3,4,5] [4,5,6,7,8])))
two = replicate 100 . product . map (*3) . zipWith max [1,2,3,4,5] $ [4,5,6,7,8]

-- If the expression ends with three parentheses,
-- chances are that if you translate it into function composition,
-- it'll have three composition operators.

-- point free style / pointless style
-- (kinda ommiting the parameter)
-- examine;
sum' :: (Num a) => [a] -> a
sum' xs = foldl (+) 0 xs
-- The xs is exposed on both right sides. Because of currying, we can omit the xs on both sides.
pointFreeSum :: (Num a) => [a] -> a
pointFreeSum = foldl (+) 0
-- This is called writing it in point free style.

-- lets translate this to point free (pointless) style
fn x = ceiling (negate (tan (cos (max 50 x))))
fn'  = ceiling . negate . tan . cos . max 50

-- Writing a function in point free style can be less readable if a function is too complex.
-- That's why making long chains of function composition is discouraged.
-- The prefered style is to use let bindings to give labels to intermediary results or
-- split the problem into sub-problems and then put it together so that the function
-- makes sense to someone reading it instead of just making a huge composition chain.

-- For example;
-- Problem: finding the sum of all odd squares that are smaller than 10,000.
-- Normal;
sol1 = sum (takeWhile (<10000) (filter odd (map (^2) [1..])))
-- With composition;
sol2 = sum . takeWhile (<10000) . filter odd . map (^2) $ [1..]
-- Preferred way;
sol3 =
    let oddSquares = filter odd $ map (^2) [1..]
        belowLimit = takeWhile (<10000) oddSquares
    in  sum belowLimit

