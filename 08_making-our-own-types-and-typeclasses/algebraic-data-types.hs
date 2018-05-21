-- # http://learnyouahaskell.com/making-our-own-types-and-typeclasses#algebraic-data-types

-- LOAD THIS FILE WITH ":l algebraic-data-types" within repl (ghci)
-- and reload with ":r"

-- THIS PART IS ABOUT EXPORTING DATA TYPES FROM OUR MODULES
-- THIS IS ACTUALLY THE LAST PART OF THE CHAPTER.
-- GO BELOW TO BEGINNING OF THE CHAPTER.

-- You can, of course, export your data types in your modules.

-- By doing Shape(..), we exported all the value constructors for Shape,
-- so that means that whoever imports our module can make shapes by using
-- the Rectangle and Circle value constructors.
-- It's the same as writing Shape (Rectangle, Circle).

module Shapes
( Point(..)
, Shape2(..)
, Shape'(..)
, Shape(..)
, surface
, nudge
, baseCircle
, baseRect
) where

-- We could also opt not to export any value constructors for Shape by just
-- writing Shape in the export statement. That way, someone importing our module
-- could only make shapes by using the auxilliary functions baseCircle and baseRect.
-- Data.Map uses that approach. You can't create a map by doing
-- Map.Map [(1,2),(3,4)] because it doesn't export that value constructor.
-- However, you can make a mapping by using one of the auxilliary functions
-- like Map.fromList. Remember, value constructors are just functions that take
-- the fields as parameters and return a value of some type (like Shape) as a result.
-- So when we choose not to export them, we just prevent the person importing our
-- module from using those functions, but if some other functions that are exported
-- return a type, we can use them to make values of our custom data types.

-- Not exporting the value constructors of a data types makes them more abstract
-- in such a way that we hide their implementation. Also, whoever uses our module
-- can't pattern match against the value constructors.

-- BEGINNING OF THE CHAPTER.

-- One way is to use the data keyword to define a type.

data Bool = False | True

-- data means that we're defining a new data type.
-- The part before the = denotes the type, which is Bool.
-- The parts after the = are value constructors.
-- They specify the different values that this type can have.
-- The | is read as or.
-- So we can read this as: the Bool type can have a value of True or False.
-- Both the type name and the value constructors have to be capital cased.

-- Lets make our own type to represent a shape.
-- Let's say that a shape can be a circle or a rectangle.

data Shape = Circle Float Float Float | Rectangle Float Float Float Float

-- The Circle value constructor has three fields, which take floats.
-- So when we write a value constructor, we can optionally add some
-- types after it and those types define the values it will contain.

-- The first two fields of Circle are the coordinates of its center,
-- the third one its radius. The Rectangle value constructor has four
-- fields which accept floats. The first two are the coordinates to its
-- upper left corner and the second two are coordinates to its lower right one.

-- Now when I say fields, I actually mean parameters.
-- Value constructors are actually functions that ultimately return a value of a data type.
-- Let's take a look at the type signatures for these two value constructors.

-- => :t Circle
-- ==> Circle :: Float -> Float -> Float -> Shape
-- =>  :t Rectangle
-- ==> Rectangle :: Float -> Float -> Float -> Float -> Shape

-- So value constructors are functions like everything else.

-- Let's make a function that takes a shape and returns its surface.

surface :: Shape -> Float
surface (Circle _ _ r) = pi * r ^ 2
surface (Rectangle x1 y1 x2 y2) = (abs $ x2 - x1) * (abs $ y2 - y1)

-- Just like we can't write a function with a type declaration of True -> Int.
-- We couldn't write a type declaration of Circle -> Float.
-- Because Circle is not a type, Shape is.

theCircle = Circle 0 0 10
-- => :t theCircle
-- ==> theCircle :: Shape
theRect = Rectangle 0 0 100 100
-- => :t theRect
-- ==> theRect :: Shape

surfaceOfTheCircle = surface theCircle
-- ==> 314.15927
surfaceOfTheRect = surface theRect
-- ==> 10000.0

-- If we try to just print out Circle 10 20 5 in the prompt, we'll get an error.
-- That's because Haskell doesn't know how to display our data type as a string

-- When we try to print a value out in the prompt, Haskell first runs the show
-- function to get the string representation of our value and then it prints
-- that out to the terminal.

-- To make our Shape type part of the Show typeclass, we declare it like this:

data Shape' = Circle' Float Float Float | Rectangle' Float Float Float Float deriving (Show)

-- Now, we can do this:
-- => Circle' 10 20 5
-- ==> Circle' 10.0 20.0 5.0
-- => Rectangle' 50 230 60 90
-- ==> Rectangle' 50.0 230.0 60.0 90.0

-- Value constructors are functions...
-- So we can map them and partially apply them and everything.

-- If we want a list of concentric circles with different radii, we can do this.
mapRadiusToCircle :: [Float] -> [Shape']
mapRadiusToCircle = map (Circle' 0 0)

-- => mapRadiusToCircle [4,5,6,6]
-- ==> [Circle' 0.0 0.0 4.0, Circle' 0.0 0.0 5.0, Circle' 0.0 0.0 6.0, Circle' 0.0 0.0 6.0]

-- Let's make an intermediate data type that defines a point in two-dimensional space.
-- Then we can use that to make our shapes more understandable.

data Point = Point Float Float deriving (Show)
data Shape2 = Circle2 Point Float | Rectangle2 Point Point deriving (Show)

-- When defining a point, we used the same name for the data type and the value constructor.
-- This has no special meaning, although it's common to use the same name as the type
-- if there's only one value constructor.

-- We have to adjust our surface function to reflect these changes.

surface2 :: Shape2 -> Float
surface2 (Circle2 _ r) = pi * r ^ 2
surface2 (Rectangle2 (Point x1 y1) (Point x2 y2)) = (abs $ x2 - x1) * (abs $ y2 - y1)

-- => surface2 (Rectangle2 (Point 0 0) (Point 100 100))
-- ==> 10000.0
-- => surface2 (Circle2 (Point 0 0) 24)
-- ==> 1809.5574

-- Let write a nudge function that takes a shape, the amount to move it on
-- the x axis and the amount to move it on the y axis and then returns a new
-- shape that has the same dimensions, only it's located somewhere else.

nudge :: Shape2 -> Float -> Float -> Shape2
nudge (Circle2 (Point x y) r) a b = Circle2 (Point (x+a) (y+b)) r
nudge (Rectangle2 (Point x1 y1) (Point x2 y2)) a b = Rectangle2 (Point (x1+a) (y1+b)) (Point (x2+a) (y2+b))

-- => nudge (Circle2 (Point 34 34) 10) 5 10
-- ==> Circle2 (Point 39.0 44.0) 10.0

-- If we don't want to deal directly with points, we can make some auxilliary
-- functions that create shapes of some size at the zero coordinates and then nudge those.

baseCircle :: Float -> Shape2
baseCircle r = Circle2 (Point 0 0) r

baseRect :: Float -> Float -> Shape2
baseRect width height = Rectangle2 (Point 0 0) (Point width height)

-- => nudge (baseRect 40 100) 60 23
-- ==> Rectangle2 (Point 60.0 23.0) (Point 100.0 123.0)


