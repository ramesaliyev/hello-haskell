-- # http://learnyouahaskell.com/making-our-own-types-and-typeclasses#derived-instances

-- LOAD THIS FILE WITH ":l derived-instances" within repl (ghci)
-- and reload with ":r"

-- A type can be made an instance of a typeclass if it supports that behavior.

-- Typeclasses are like interfaces. We don't make data from typeclasses.
-- Instead, we first make our data type and then we think about what it
-- can act like. If it can act like something that can be equated,
-- we make it an instance of the Eq typeclass. If it can act like something
-- that can be ordered, we make it an instance of the Ord typeclass.

-- Let's see how Haskell can automatically make our type an instance of
-- any of the following typeclasses: Eq, Ord, Enum, Bounded, Show, Read.
-- Haskell can derive the behavior of our types in these contexts if we
-- use the deriving keyword when making our data type.

data Person = Person { firstName :: String
                     , lastName :: String
                     , age :: Int
                     } deriving (Eq, Show, Read)

-- When we derive the Eq instance for a type and then try to compare two
-- values of that type with == or /=, Haskell will see if the value constructors
-- match (there's only one value constructor here though) and then it will check
-- if all the data contained inside matches by testing each pair of fields
-- with ==. There's only one catch though, the types of all the fields also
-- have to be part of the Eq typeclass. But since both String and Int are,
-- we're OK. Let's test our Eq instance.

-- The Show and Read typeclasses are for things that can be converted to or
-- from strings, respectively. Like with Eq, if a type's constructors have fields,
-- their type has to be a part of Show or Read if we want to make our type an
-- instance of them.

jane = Person {firstName = "Jane", lastName = "Doe", age = 30}
joe = Person {firstName = "Joe", lastName = "Doe", age = 30}
joe2 = Person {firstName = "Joe", lastName = "Doe", age = 30}

-- => jane == joe
-- ==> False

-- => joe2 == joe
-- ==> True

-- => joe
-- ==> Person {firstName = "Joe", lastName = "Doe", age = 30}

-- Read is for converting strings to values of our type. Remember though,
-- when we use the read function, we have to use an explicit type annotation
-- to tell Haskell which type we want to get as a result. If we don't make
-- the type we want as a result explicit, Haskell doesn't know which type we want.

mikeFromString = read "Person {firstName =\"Michael\", lastName =\"Diamond\", age = 43}" :: Person

-- ==> mikeFromString
-- ==> Person {firstName = "Michael", lastName = "Diamond", age = 43}

-- If we use the result of our read later on in a way that Haskell can infer
-- that it should read it as a person, we don't have to use type annotation.

isThisMike = read "Person {firstName =\"Michael\", lastName =\"Diamond\", age = 43}" == mikeFromString

-- => isThisMike
-- ==> True

-- We can also read parameterized types, but we have to fill in the type parameters.
-- So we can't do read "Just 't'" :: Maybe a, but we can do read "Just 't'" :: Maybe Char.

-- We can derive instances for the Ord type class, which is for types that have values that
-- can be ordered. If we compare two values of the same type that were made using different
-- constructors, the value which was made with a constructor that's defined first is
-- considered smaller.

-- For instance, consider the Bool type, which can have a value of either False or True.

data Bool = False | True deriving (Eq, Ord)

-- Because the False value constructor is specified first and the True value constructor
-- is specified after it, we can consider True as greater than False.

-- => True `compare` False
-- ==> GT
-- => True > False
-- ==> True
-- => True < False
-- ==> False

-- In the Maybe a data type, the Nothing value constructor is specified before the Just
-- value constructor, so a value of Nothing is always smaller than a value of Just
-- something, even if that something is minus one billion trillion. But if we compare
-- two Just values, then it goes to compare what's inside them.

-- => Nothing < Just 100
-- ==> True
-- => Nothing > Just (-49999)
-- ==> False
-- => Just 3 `compare` Just 2
-- ==> GT
-- => Just 100 > Just 50
-- ==> True

-- But we can't do something like Just (*3) > Just (*2), because (*3) and
-- (*2) are functions, which aren't instances of Ord.

-- We can easily use algebraic data types to make enumerations and
-- the Enum and Bounded typeclasses help us with that.

data Day = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday
           deriving (Eq, Ord, Show, Read, Bounded, Enum)

-- Because all the value constructors are nullary (take no parameters, i.e. fields),
-- we can make it part of the Enum typeclass.

-- Enum typeclass is for things that have predecessors and successors.
-- Bounded typeclass is for things that have a lowest possible value and highest possible value.
-- Show and Read typeclasses are for converting values of this type to and from strings.
-- Eq and Ord typeclasses are for comparing or equating values

-- [Show]
-- => Wednesday
-- ==> Wednesday
-- => show Wednesday
-- ==> "Wednesday"

-- [Read]
-- => read "Saturday" :: Day
-- ==> Saturday

-- [Eq]
-- => Saturday == Sunday
-- ==> False
-- => Saturday == Saturday
-- ==> True

-- [Ord]
-- => Saturday > Friday
-- ==> True
-- => Monday `compare` Wednesday
-- ==> LT

-- [Bounded]
-- => minBound :: Day
-- ==> Monday
-- => maxBound :: Day
-- ==> Sunday

-- [Enum]
-- => succ Monday
-- ==> Tuesday
-- => pred Saturday
-- ==> Friday
-- => [Thursday .. Sunday]
-- ==> [Thursday,Friday,Saturday,Sunday]
-- => [minBound .. maxBound] :: [Day]
-- ==> [Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday]
