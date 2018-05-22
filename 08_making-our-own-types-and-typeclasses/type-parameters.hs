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


-- --> THIS FEATURE IS REMOVED FROM HASKELL
-- https://stackoverflow.com/a/18935003

-- We used to could add a typeclass constraint in the data declaration:

-- data (Ord k) => Map k v = Something k v | Otherthing k v

-- This (obviously) means that the type of k has to be member
-- of the Ord typeclass. However, it's a very strong convention
-- in Haskell to never add typeclass constraints in data declarations.

-- Because If we put or don't put the Ord k constraint in the data declaration
-- for Map k v, we're going to have to put the constraint into functions that
-- assume the keys in a map can be ordered. But if we don't put the constraint
-- in the data declaration, we don't have to put (Ord k) => in the type declarations
-- of functions that don't care whether the keys can be ordered or not. An example
-- of such a function is toList, that just takes a mapping and converts it to an
-- associative list. Its type signature is toList :: Map k a -> [(k, a)].
-- If Map k v had a type constraint in its data declaration, the type for toList
-- would have to be toList :: (Ord k) => Map k a -> [(k, a)], even though the
-- function doesn't do any comparing of keys by order.

-- So don't put type constraints into data declarations even if it seems to
-- make sense, because you'll have to put them into the function type declarations either way.
-- --> THIS FEATURE IS REMOVED FROM HASKELL


-- Let's implement a 3D vector type and add some operations for it.
-- We'll be using a parameterized type because even though it will
-- usually contain numeric types, it will still support several of them.

data Vector a = Vector a a a deriving (Show)

vplus :: (Num t) => Vector t -> Vector t -> Vector t
(Vector i j k) `vplus` (Vector l m n) = Vector (i+l) (j+m) (k+n)

vectMult :: (Num t) => Vector t -> t -> Vector t
(Vector i j k) `vectMult` m = Vector (i*m) (j*m) (k*m)

scalarMult :: (Num t) => Vector t -> Vector t -> t
(Vector i j k) `scalarMult` (Vector l m n) = i*l + j*m + k*n

-- => Vector 3 5 8 `vplus` Vector 9 2 8
-- ==> Vector 12 7 16

-- These functions can operate on types of
-- Vector Int, Vector Integer, Vector Float, whatever,
-- as long as the a from Vector a is from the Num typeclass.

--  Also, if you examine the type declaration for these functions,
-- you'll see that they can operate only on vectors of the same type
-- and the numbers involved must also be of the type that is contained
-- in the vectors. Notice that we didn't put a Num class constraint
-- in the data declaration, because we'd have to repeat it in the functions anyway.

-- Tt's very important to distinguish between the type constructor and the
-- value constructor. When declaring a data type, the part before the = is
-- the type constructor and the constructors after it (possibly separated by |'s)
-- are value constructors. Giving a function a type of
-- Vector t t t -> Vector t t t -> t would be wrong, because we have to put types
-- in type declaration and the vector type constructor takes only one parameter,
-- whereas the value constructor takes three.

