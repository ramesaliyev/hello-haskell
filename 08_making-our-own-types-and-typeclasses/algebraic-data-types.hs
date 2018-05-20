-- # http://learnyouahaskell.com/making-our-own-types-and-typeclasses#algebraic-data-types

-- LOAD THIS FILE WITH ":l algebraic-data-types" within repl (ghci)
-- and reload with ":r"

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

