-- # http://learnyouahaskell.com/making-our-own-types-and-typeclasses#type-parameters

-- LOAD THIS FILE WITH ":l type-parameters" within repl (ghci)
-- and reload with ":r"

-- A value constructor can take some values parameters and then produce
-- a new value. For instance, the Car constructor takes three values
-- and produces a car value. In a similar manner, type constructors
-- can take types as parameters to produce new types.

data Maybe a = Nothing | Just a

-- The a here is the type parameter. And because there's a type parameter
-- involved, we call Maybe a type constructor. Depending on what we want
-- this data type to hold when it's not Nothing, this type constructor
-- can end up producing a type of Maybe Int, Maybe Car, Maybe String, etc.
-- No value can have a type of just Maybe, because that's not a type per se,
-- it's a type constructor. In order for this to be a real type that a value
-- can be part of, it has to have all its type parameters filled up.

-- So if we pass Char as the type parameter to Maybe, we get a type of
-- Maybe Char. The value Just 'a' has a type of Maybe Char, for example.

-- The list type was also a type that has a type parameter.
-- Although there's some syntactic sugar in play, the list type takes a
-- parameter to produce a concrete type.
-- Values can have an [Int] type, a [Char] type, a [[String]] type,
-- but you can't have a value that just has a type of [].

-- => :t Just "Haha"
-- ==> Just "Haha" :: Maybe [Char]

-- Type parameters are useful because we can make different types with
-- them depending on what kind of types we want contained in our data type.

-- Notice that the type of Nothing is Maybe a. Its type is polymorphic.
-- If some function requires a Maybe Int as a parameter, we can give it a Nothing,
-- because a Nothing doesn't contain a value anyway and so it doesn't matter.

-- The Maybe a type can act like a Maybe Int if it has to, just like 5 can act
-- like an Int or a Double. Similarly, the type of the empty list is [a].
-- An empty list can act like a list of anything. That's why we can do
-- [1,2,3] ++ [] and ["ha","ha","ha"] ++ [].

-- We usually use type parameters when the type that's contained inside the
-- data type's various value constructors isn't really that important for
-- the type to work.
