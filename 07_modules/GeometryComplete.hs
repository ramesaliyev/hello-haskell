-- # http://learnyouahaskell.com/modules#making-our-own-modules

-- LOAD THIS FILE WITH ":l GeometryComplete" within repl (ghci)
-- and reload with ":r"

-- GeometryComplete module.

-- At the beginning of a module, we specify the module name.
-- If we have a file called Geometry.hs, then we should name our module Geometry.
-- Then, we specify the functions that it exports and after that,
-- we can start writing the functions.

module GeometryComplete
( sphereVolume
, sphereArea
, cubeVolume
, cubeArea
, cuboidArea
, cuboidVolume
) where

sphereVolume :: Float -> Float
sphereVolume radius = (4.0 / 3.0) * pi * (radius ^ 3)

sphereArea :: Float -> Float
sphereArea radius = 4 * pi * (radius ^ 2)

cubeVolume :: Float -> Float
cubeVolume side = cuboidVolume side side side

cubeArea :: Float -> Float
cubeArea side = cuboidArea side side side

cuboidVolume :: Float -> Float -> Float -> Float
cuboidVolume a b c = rectangleArea a b * c

cuboidArea :: Float -> Float -> Float -> Float
cuboidArea a b c = rectangleArea a b * 2 + rectangleArea a c * 2 + rectangleArea c b * 2

rectangleArea :: Float -> Float -> Float
rectangleArea a b = a * b
