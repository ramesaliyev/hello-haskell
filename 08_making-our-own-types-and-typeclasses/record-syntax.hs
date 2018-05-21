-- # http://learnyouahaskell.com/making-our-own-types-and-typeclasses#record-syntax

-- LOAD THIS FILE WITH ":l record-syntax" within repl (ghci)
-- and reload with ":r"

-- If we want Person data type, we can define it like;

data Person' = Person' String String Int Float String String deriving (Show)

-- But when defining big data types, record syntax is more useful.

data Person = Person { firstName :: String
                     , lastName :: String
                     , age :: Int
                     , height :: Float
                     , phoneNumber :: String
                     , flavor :: String
                     } deriving (Show)

-- The resulting data type is exactly the same.

-- First we write the name of the field, for instance,
-- firstName and then we write a double colon ::
-- (also called Paamayim Nekudotayim, haha) and then we specify the type.

-- The main benefit of this is that it creates functions that lookup
-- fields in the data type. By using record syntax to create this data type,
-- Haskell automatically made these functions:
-- firstName, lastName, age, height, phoneNumber and flavor.

guy = Person "Buddy" "Finklestein" 43 184.2 "526-2928" "Chocolate"

-- => firstName guy
-- ==> "Buddy"
-- => flavor guy
-- ==> "Chocolate"

-- When we derive Show for the type, it displays it differently
-- if we use record syntax to define and instantiate the type.

data Car' = Car' String String Int deriving (Show)

-- => Car' "Ford" "Mustang" 1967
-- ==> Car' "Ford" "Mustang" 1967

-- If we define it using record syntax, we can make a new car like this.

data Car = Car {company :: String, model :: String, year :: Int} deriving (Show)

-- => Car {company="Ford", model="Mustang", year=1967}
-- ==> Car {company = "Ford", model = "Mustang", year = 1967}

-- When making a new car, we don't have to necessarily put the fields in
-- the proper order, as long as we list all of them. But if we don't use
-- record syntax, we have to specify them in order.

-- Use record syntax when a constructor has several fields and
-- it's not obvious which field is which.
