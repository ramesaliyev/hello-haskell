-- # http://learnyouahaskell.com/higher-order-functions#curried-functions

-- LOAD THIS FILE WITH ":l curried" within repl (ghci)
-- and reload with ":r"

-- Haskell functions can take functions as parameters and
-- return functions as return values. A function that does
-- either of those is called a higher order function.

-- Higher order functions aren't just a part of the Haskell experience,
-- they pretty much are the Haskell experience.

-- Every function in Haskell officially only takes one parameter.
-- All the functions that accepted several parameters so far have been curried functions.

-- For example:
-- Doing max 4 5 first creates a function that takes a parameter
-- and returns either 4 or that parameter, depending on which is bigger.
-- Then, 5 is applied to that function and that function produces our desired result.

-- The following two calls are equivalent:
theMax = max 4 5
theMax' = (max 4) 5

-- Putting a space between two things is simply function application.

-- The space is sort of like an operator and it has the highest precedence.

-- Let's examine the type of max.
-- max :: (Ord a) => a -> a -> a
-- Which can also be written as 
-- max :: (Ord a) => a -> (a -> a)

-- That could be read as: max takes an a and returns (that's the ->) a function
-- that takes an a and returns an a. That's why the return type and the
--parameters of functions are all simply separated with arrows.

-- If we call a function with too few parameters,
-- we get back a partially applied function,
-- meaning a function that takes as many parameters as we left out.
-- This is a neat way to create functions on the fly so we can pass
-- them to another function or to seed them with some data.

multThree :: (Num a) => a -> a -> a -> a  
multThree x y z = x * y * z

multTwoWithNine = multThree 9
-- => multTwoWithNine 2 3

multWithEighteen = multTwoWithNine 2
-- => multWithEighteen 10

-- What if we wanted to create a function that takes a number and compares it to 100?
compareWithHundred :: (Num a, Ord a) => a -> Ordering  
compareWithHundred x = compare 100 x
-- But compare 100 already returns a function that takes a number and compares it with 100.
-- So..
compareWithHundred' :: (Num a, Ord a) => a -> Ordering  
compareWithHundred' = compare 100

-- Infix functions can also be partially applied by using sections.
-- To section an infix function, simply surround it with parentheses
-- and only supply a parameter on one side. That creates a function
-- that takes one parameter and then applies it to the side that's missing an operand. 
divideByTen :: (Floating a) => a -> a  
divideByTen = (/10)
-- => divideByTen 200
-- ==> 20.0
divideThousandBy :: (Floating a) => a -> a  
divideThousandBy = (1000/)
-- => divideThousandBy 25
-- ==> 40

-- A function that checks if a character supplied to it is an uppercase letter:
isUpperAlphanum :: Char -> Bool  
isUpperAlphanum = (`elem` ['A'..'Z'])

-- The only special thing about sections is using -. From the definition of sections,
-- (-4) would result in a function that takes a number and subtracts 4 from it.
-- However, for convenience, (-4) means minus four. So if you want to make a function
-- that subtracts 4 from the number it gets as a parameter, partially apply the
-- subtract function like so: (subtract 4).

