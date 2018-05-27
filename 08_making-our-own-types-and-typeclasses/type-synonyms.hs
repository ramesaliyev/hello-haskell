-- # http://learnyouahaskell.com/making-our-own-types-and-typeclasses#type-synonyms

-- LOAD THIS FILE WITH ":l type-synonyms" within repl (ghci)
-- and reload with ":r"

import Data.Map (Map)

-- Previously, we mentioned that when writing types, the [Char] and String
-- types are equivalent and interchangeable. That's implemented with type synonyms.

-- Type synonyms don't really do anything per se, they're just about giving some
-- types different names so that they make more sense to someone reading our code and documentation.

type String' = [Char]

-- Type keyword is just for making a synonym for an already existing type.

-- toUpperString :: [Char] -> [Char]
-- or
-- toUpperString :: String -> String
-- Both of these are essentially the same, only the latter is nicer to read.

-- instead of this -> type PhoneBook = [(String,String)]
type PhoneNumber = String
type Name = String
type PhoneBook = [(Name, PhoneNumber)]

-- instead of this -> phoneBook :: [(String,String)]
phoneBook :: PhoneBook
phoneBook =
    [("betty","555-2938")
    ,("bonnie","452-2928")
    ,("patsy","493-2928")
    ,("lucille","205-2928")
    ,("wendy","939-8282")
    ,("penny","853-2492")
    ]

-- instead of this -> String -> String -> [(String,String)] -> Bool
inPhoneBook :: Name -> PhoneNumber -> PhoneBook -> Bool
inPhoneBook name pnumber pbook = (name,pnumber) `elem` pbook

-- Type synonyms can also be parameterized. If we want a type that represents
-- an association list type but still want it to be general so it can use any
-- type as the keys and values, we can do this:

type AssocList k v = [(k,v)]

-- Now, a function that gets the value by a key in an association list can have a type of
-- (Eq k) => k -> AssocList k v -> Maybe v
-- AssocList is a type constructor that takes two types and produces a concrete type,
-- like AssocList Int String, for instance.

-- By concrete type author means fully applied types like Map Int String or if we're
-- dealin' with one of them polymorphic functions, [a] or (Ord a) => Maybe a and stuff.
-- And he continues; Sometimes me and the boys say that Maybe is a type, but we don't
-- mean that, cause every idiot knows Maybe is a type constructor. When I apply an
-- extra type to Maybe, like Maybe String, then I have a concrete type.
-- You know, values can only have types that are concrete types!

-- Just like we can partially apply functions to get new functions,
-- we can partially apply type parameters and get new type constructors from them.
-- Just like we call a function with too few parameters to get back a new function,
-- we can specify a type constructor with too few type parameters and get back a
-- partially applied type constructor.

-- If we wanted a type that represents a map (from Data.Map) from integers to
-- something, we could either do this:

type IntMap v = Map Int v

-- or

type IntMap' = Map Int

-- Either way, the IntMap type constructor takes one parameter and that is
-- the type of what the integers will point to.

-- Make sure that you really understand the distinction between type constructors
-- and value constructors. Just because we made a type synonym called IntMap or
-- AssocList doesn't mean that we can do stuff like AssocList [(1,2),(4,5),(7,9)].
-- All it means is that we can refer to its type by using different names.
-- We can do [(1,2),(3,5),(8,9)] :: AssocList Int Int, which will make the numbers
-- inside assume a type of Int, but we can still use that list as we would any normal
-- list that has pairs of integers inside. Type synonyms (and types generally)
-- can only be used in the type portion of Haskell. We're in Haskell's type portion
-- whenever we're defining new types (so in data and type declarations) or when
-- we're located after a ::. The :: is in type declarations or in type annotations.

