-- # http://learnyouahaskell.com/making-our-own-types-and-typeclasses#type-synonyms

-- LOAD THIS FILE WITH ":l type-synonyms" within repl (ghci)
-- and reload with ":r"

-- Previously, we mentioned that when writing types, the [Char] and String
-- types are equivalent and interchangeable. That's implemented with type synonyms.

-- Type synonyms don't really do anything per se, they're just about giving some
-- types different names so that they make more sense to someone reading our code and documentation.

type String = [Char]

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

