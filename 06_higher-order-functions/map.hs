-- # http://learnyouahaskell.com/higher-order-functions#maps-and-filters

-- LOAD THIS FILE WITH ":l map" within repl (ghci)
-- and reload with ":r"

-- Thanks to Haskell's laziness, even if you map something over a list
-- several times and filter it several times, it will only pass over the list once.

-- map
-- takes a function and a list and applies that function to every
-- element in the list, producing a new list.

map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x:xs) = f x : map f xs

-- => map (++ "!") ["BIFF", "BANG", "POW"]
-- ==> ["BIFF!","BANG!","POW!"]

-- => map (map (^2)) [[1,2],[3,4,5,6],[7,8]]
-- ==> [[1,4],[9,16,25,36],[49,64]]

-- GOOD THING;
-- We can also do stuff like map (*) [0..]
--
-- What happens here is that the number in the list is applied to the function *.
-- (which has a type of (Num a) => a -> a -> a)
--
-- Applying only one parameter to a function that takes two parameters returns
-- a function that takes one parameter.
--
-- If we map * over the list [0..], we get back a list of functions that
-- only take one parameter, so (Num a) => [a -> a]
--
-- map (*) [0..] produces a list like the one we'd get by writing [(0*),(1*),(2*),(3*),(4*),(5*)..

listOfFuns = map (*) [0..]
multiply x y = (listOfFuns !! x) y
