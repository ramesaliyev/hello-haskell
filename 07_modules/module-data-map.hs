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

-- > null
-- checks if a map is empty.

-- > size
-- reports the size of a map.

-- > singleton
-- takes a key and a value and creates a map that has exactly one mapping.

-- > lookup
-- works like the Data.List lookup, only it operates on maps.
-- It returns Just something if it finds something for the key and Nothing if it doesn't.

-- > member
-- is a predicate takes a key and a map and reports whether the key is in the map or not.

-- > map & filter
-- work much like their list equivalents.
-- => Map.map (*100) $ Map.fromList [(1,1),(2,4),(3,9)]
-- ==> fromList [(1,100),(2,400),(3,900)]
-- => Map.filter isUpper $ Map.fromList [(1,'a'),(2,'A'),(3,'b'),(4,'B')]
-- ==> fromList [(2,'A'),(4,'B')]

-- > toList
-- is the inverse of fromList.
-- => Map.toList . Map.insert 9 2 $ Map.singleton 4 3
-- ==> [(4,3),(9,2)]

-- > keys & elems
-- return lists of keys and values respectively.
-- keys is the equivalent of map fst . Map.toList
-- elems is the equivalent of map snd . Map.toList

-- > fromListWith
-- it uses a function supplied to it to decide what to do with duplicates.

-- Let's say that a girl can have several numbers and we have an association list set up like this.

phoneBookWDuplicates =
  [("betty","555-2938")
  ,("betty","342-2492")
  ,("bonnie","452-2928")
  ,("patsy","493-2928")
  ,("patsy","943-2929")
  ,("patsy","827-9162")
  ,("lucille","205-2928")
  ,("wendy","939-8282")
  ,("penny","853-2492")
  ,("penny","555-2111")
  ]

-- Concat numbers with comma.

phoneBookToMap :: (Ord k) => [(k, String)] -> Map.Map k String
phoneBookToMap xs = Map.fromListWith (\number1 number2 -> number1 ++ ", " ++ number2) xs

-- Generate phone book map.

richPhoneBookMap = phoneBookToMap phoneBookWDuplicates

-- => Map.lookup "patsy" richPhoneBookMap
-- ==> "827-9162, 943-2929, 493-2928"

-- We could also first make all the values in the association list
-- singleton lists and then we can use ++ to combine the numbers.

phoneBookToMap' :: (Ord k) => [(k, a)] -> Map.Map k [a]
phoneBookToMap' xs = Map.fromListWith (++) $ map (\(k,v) -> (k,[v])) xs

-- Generate phone book map.

richPhoneBookMap' = phoneBookToMap' phoneBookWDuplicates

-- => Map.lookup "patsy" richPhoneBookMap'
-- ==> [ "827-9162", "943-2929", "493-2928" ]

-- We would want the biggest value for the key to be kept.
-- => Map.fromListWith max [(2,3),(2,5),(2,100),(3,29),(3,22),(3,11),(4,22),(4,15)]
-- ==> [(2,100),(3,29),(4,22)]

-- Or we could choose to add together values on the same keys.
-- => Map.fromListWith (+) [(2,3),(2,5),(2,100),(3,29),(3,22),(3,11),(4,22),(4,15)]
-- ==> [(2,108),(3,62),(4,37)]

-- > insertWith
-- It inserts a key-value pair into a map, but if that map already contains the key,
-- it uses the function passed to it to determine what to do.
-- => Map.insertWith (+) 3 100 $ Map.fromList [(3,4),(5,103),(6,339)]
-- ==> [(3,104),(5,103),(6,339)]
