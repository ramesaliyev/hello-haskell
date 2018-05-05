-- Tuples are like lists, they are a way to store several values into a single value.

-- Tuples are used when you know exactly how many values you want to combine and its
-- type depends on how many components it has and the types of the components.

-- Tuples don't have to be homogenous. They can contain a combination of several types.

-- Tuple of size two also called a pair.

tuple = (1, 2)
tuples = [(1,2), (8,11), (4,5)]

-- ERROR! [(1,2), (8,11,5), (4,5)]
-- Because two sized tuple and three sized tuple are two different types.

-- You can do this;
tuplesTwo = [(1, "one"), (2, "two")]
-- But not this
-- ERROR! [(1, "one"), (2, 2)]
-- Because again their types are different in the later one.

-- Tuples can also contain lists.
listTuple = ([1,3,5], [2,4,6])
listTupleInList = [([1], [2]), ([3], [4])]
-- ERROR! [([1],[2]),([3],["a"])]

-- Tuples are much more rigid because each different size of tuple is its own type,
-- so you can't write a general function to append an element to a tuple.

-- There's no such thing as a singleton tuple.

-- Tuples can be compared with each other if their components can be compared.

-- some pair functions (Tuple of size two.)
-- > fst (...) (returns first component of pair)
-- > snd (...) (returns second component of pair)

-- some tuple functions

-- > zip [...] [...] (takes two lists and zips them together into one list by joining the matching elements into pairs.)
-- => zip [1 .. 5] ["one", "two", "three", "four", "five"]
-- ==> [(1,"one"),(2,"two"),(3,"three"),(4,"four"),(5,"five")]
-- Longer list simply gets cut off to match the length of the shorter one.
-- Because of Haskell is lazy we can use infinite lists with finite lists.
-- => zip [1..] ["apple", "orange", "cherry", "mango"]
-- ==> [(1,"apple"),(2,"orange"),(3,"cherry"),(4,"mango")]


