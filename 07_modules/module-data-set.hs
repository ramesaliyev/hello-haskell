-- # http://learnyouahaskell.com/modules#data-set

-- LOAD THIS FILE WITH ":l module-data-set" within repl (ghci)
-- and reload with ":r"

-- Because the names in Data.Set clash with a lot of Prelude
-- and Data.List names, we do a qualified import.
import qualified Data.Set as Set

-- Sets are kind of like a cross between lists and maps.
-- All the elements in a set are unique.
-- Because they're internally implemented with trees they're ordered.

-- Checking for membership, inserting, deleting, etc. is much faster than
-- doing the same thing with lists.

-- The most common operation when dealing with sets are inserting into a set,
-- checking for membership and converting a set to a list.

text1 = "I just had an anime dream. Anime... Reality... Are they so different?"
text2 = "The old man left his garbage can out and now his trash is all over my lawn!"

-- > fromList
-- It takes a list and converts it into a set.

set1 = Set.fromList text1
-- ==> " .?AIRadefhijlmnorstuy"
set2 = Set.fromList text2
-- ==> " !Tabcdefghilmnorstuvwy"

-- > intersection
-- finds common elements in sets.
sharedLetters = Set.intersection set1 set2
-- ==> " adefhilmnorstuy"

-- > difference
-- finds elements that are in the first set but aren't in the second one.
diffOneTwo = Set.difference set1 set2
-- ==> ".?AIRj"
diffTwoOne = Set.difference set2 set1
-- ==> "!Tbcgvw"

-- > union
-- all the unique letters used in both sets.
letterUnion = Set.union set1 set2
-- => " !.?AIRTabcdefghijlmnorstuvwy"

-- > map
-- > filter
-- > null
-- > size
-- > member
-- > empty
-- > singleton
-- > insert
-- > delete
-- these functions all work like you'd expect them to.

-- > isSubsetOf
-- Set A is a subset of set B if B contains all the elements that A does.

-- > isProperSubsetOf
-- Set A is a proper subset of set B if B contains all the elements that A does but has more elements.

-- Sets are often used to weed a list of duplicates from a list by first making it
-- into a set with fromList and then converting it back to a list with toList.
-- The Data.List function nub already does that, but weeding out duplicates for large
-- lists is much faster if you cram them into a set and then convert them back to a
-- list than using nub. But using nub only requires the type of the list's elements
-- to be part of the Eq typeclass, whereas if you want to cram elements into a set,
-- the type of the list has to be in Ord.

setNub xs = Set.toList $ Set.fromList xs

-- => setNub "HEY WHATS CRACKALACKIN"
-- ==> " ACEHIKLNRSTWY"
-- => nub "HEY WHATS CRACKALACKIN"
-- ==> "HEY WATSCRKLIN"

-- setNub is generally faster than nub on big lists but as you can see,
-- nub preserves the ordering of the list's elements, while setNub does not.
