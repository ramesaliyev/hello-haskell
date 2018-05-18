-- # http://learnyouahaskell.com/modules#data-map

-- LOAD THIS FILE WITH ":l module-data-map" within repl (ghci)
-- and reload with ":r"

-- Because Data.Map exports functions that clash with the
-- Prelude and Data.List ones, we'll do a qualified import.
import qualified Data.Map as Map

import Data.List

-- Association lists (also called dictionaries) are lists that are used to
-- store key-value pairs where ordering doesn't matter.

-- The most obvious way to represent association lists in
-- Haskell would be by having a list of pairs.

phoneBook =
  [("betty","555-2938")
  ,("bonnie","452-2928")
  ,("patsy","493-2928")
  ,("lucille","205-2928")
  ,("wendy","939-8282")
  ,("penny","853-2492")
  ]

-- Let's make a function that looks up some value given a key.

findKey :: (Eq k) => k -> [(k,v)] -> v
findKey key xs = snd . head . filter (\(k,v) -> key == k) $ xs

-- => findKey "betty" phoneBook
-- ==> "555-2938"

-- But what happens if the key we're looking for isn't in the association list?
-- It will throw a runtime error.

-- So let's use the Maybe data type.
-- If we don't find the key, we'll return a Nothing.
-- If we find it, we'll return Just something, where something is the value corresponding to that key.

findKey' :: (Eq k) => k -> [(k,v)] -> Maybe v
findKey' key [] = Nothing
findKey' key ((k,v):xs) = if key == k
                            then Just v
                            else findKey' key xs

-- => findKey' "penny" phoneBook
-- ==> Just "853-2492"
-- => findKey' "pennay" phoneBook
-- => Nothing

-- We just implemented the lookup function from Data.List.

-- => lookup "penny" phoneBook
-- ==> Just "853-2492"
-- => lookup "pennay" phoneBook
-- => Nothing

-- If we want to find the corresponding value to a key,
-- we have to traverse all the elements of the list until we find it.
-- The Data.Map module offers association lists that are much faster
-- (because they're internally implemented with trees) and also it provides
-- a lot of utility functions. From now on, we'll say we're working with
-- maps instead of association lists.

-- > fromList
-- function takes an association list (in the form of a list) and returns a map with the same associations.
-- If there are duplicate keys in the original association list, the duplicates are just discarded.
phoneBookMap = Map.fromList phoneBook

-- The essential constraint in the Data.Map module is keys have to be orderable.
-- Because it needs the keys to be orderable so it can arrange them in a tree.

-- > empty
-- It takes no arguments, it just returns an empty map.

-- > insert
-- It takes a key, a value and a map and returns a new map that's
-- just like the old one, only with the key and value inserted.

-- We can implement our own fromList by using the empty map, insert and a fold. Watch:

fromList' :: (Ord k) => [(k,v)] -> Map.Map k v
fromList' = foldr (\(k,v) acc -> Map.insert k v acc) Map.empty

