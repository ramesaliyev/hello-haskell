-- # http://learnyouahaskell.com/types-and-typeclasses#typeclasses-101

-- LOAD THIS FILE WITH ":l typeclasses-101" within repl (ghci)
-- and reload with ":r"

-- Typeclasses are like Interfaces that defines some behavior.
-- If a type is a part of a typeclass, that means that it supports and
-- implements the behavior the typeclass describes.

-- Lets check type definition of == function/operator.
-- => :t (==)
-- ==> (==) :: (Eq a) => a -> a -> Bool

-- Everything before the => symbol is called a class constraint.
-- So we can read this type definition as;
-- (==) takes two params of same type and returns a Bool type value,
-- BUT two params must must be members of the Eq class.
-- In this case the Eq typeclass provides an interface for testing for equality.

-- All standard Haskell types except for IO and functions are a part of the Eq typeclass.

-- Example;
-- The elem function has a type of (Eq a) => a -> [a] -> Bool.
-- Because it uses == operator to check values.
-- So definition means function will take a type named a,
-- which implements the behaviors that Eq class describes.

-- We can also see type classes when defining functions without types.
-- Haskell's type inference will ad Eq for us.
-- => iseq x y = x == y
-- => :t iseq
-- ==> iseq :: Eq a => a -> a -> Bool

-- Some Basic Typeclasses:

-- > Eq
-- is used for types that support equality testing.
-- members of it implements == and /=
-- if a function type definition includes Eq it means function will use == or /=
-- All the types we mentioned previously except for functions are part of Eq.

-- > Ord
-- is for types that have an ordering.
-- covers all the standard comparing functions such as >, <, >= and <=
-- To be a member of Ord, a type must first be a member of Eq.
-- All the types we covered so far except for functions are part of Ord.
-- For example:
-- compare functions takes two arguments which are members of Ord,
-- and returns an value of Ordering type.
-- Ordering is a type that can be GT, LT or EQ, meaning greater than, lesser than and equal.

-- > Show
-- is for types that can be presented as string.
-- All the types we covered so far except for functions are part of Show.
-- Check some functions for example.

-- > Enum
-- Enum members are sequentially ordered types — they can be enumerated.
-- We can use them in ranges like;
-- => ['a'..'e']
-- ==> "abcde"
-- We can get them successors and predecesors because they have defined successors and predecesors;
-- => succ 1
-- ==> 2
-- => pred 5
-- ==> 4
-- Types in this class: (), Bool, Char, Ordering, Int, Integer, Float and Double.

-- > Bounded
-- Bounded members have an upper and a lower bound.
-- Like Int, Char, Bool.
-- We can get bounds with minBound maxBound functions.
-- => maxBound Bool
-- ==> True
-- => minBound Bool
-- ==> False
-- All tuples are also part of Bounded if the components are also in it.

-- > Num
-- Num is a numeric typeclass. Its members have the property of being able to act like numbers.
-- Wole numbers are also polymorphic constants. They can act like any type that's a member of the Num typeclass.
-- => :t 20
-- ==> (Num t) => t
-- Int, Integer, Float, Double are types that are in the Num typeclass.
-- If we examine the type of *, we'll see that it accepts all numbers.
-- => :t (*)
-- ==> (*) :: (Num a) => a -> a -> a
-- To join Num, a type must already be friends with Show and Eq.
-- Num is not a subclass of Ord.

-- > Integral
-- Integral is also a numeric typeclass.
-- Num includes all numbers, including real numbers and integral numbers,
-- Integral includes only integral (whole) numbers. In this typeclass are Int and Integer.

-- > Floating
-- Includes only floating point numbers, so Float and Double.

-- > Read
-- Takes a string and return a type which is also a member of Read.
-- Which type of value it should return?
-- Compiler will told him by infering our usage of value.
-- For example:
-- => read "8.2" + "3.8"
-- ==> 12
-- => "True" || False
-- ==> True
-- => read "[1,2,3,4]" ++ [3]
-- ==> [1,2,3,4,3]
-- => read "1" : [2]
-- ==> [1,2]
-- As you can see read returns a type which is "a" (type variable) by knowing what we are doing with that value.

-- Explicit Type Annotations

-- Type annotations are a way of explicitly saying what the type of an expression should be.
-- We do that by adding :: at the end of the expression and then specifying a type.
-- For example, when we dont using return value from read, compiler cant know what type it should return.
-- So we have to explicitly told type.
-- => read "5" :: Int
-- ==>  5
-- => read "(3, 'a')" :: (Int, Char)
-- ==> (3, 'a')

-- Multiple Class Constraints

-- It's totaly ok to have multiple Class Constraits.
-- For example lets examine function fromIntegral.
-- It takes an integral number and turns it into a more general number.
-- => :t fromIntegral
-- ==> fromIntegral :: (Num b, Integral a) => a -> b
-- So it takes a Integral and returns a Num.

-- Order of constraits is not importanti constraits mean our function will work with that typeclasses.
-- Lets swap places of fromIntegral constraits:
fromIntegral' :: (Integral a, Num b) => a -> b
fromIntegral' n = fromIntegral n
