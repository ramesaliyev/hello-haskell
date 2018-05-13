-- # http://learnyouahaskell.com/modules#loading-modules

-- LOAD THIS FILE WITH ":l loading" within repl (ghci)
-- and reload with ":r"

-- A Haskell...
-- ...module is a collection of related functions, types and typeclasses.
-- ...program is a collection of modules where the main module loads up
-- the other modules and then uses the functions defined in them to do something.

-- Self-contained modules which don't rely on each
-- other too much called loosely coupled.

-- All the functions, types and typeclasses that we've dealt with so far were
-- part of the Prelude module, which is imported by default.

-- The syntax for importing modules in a Haskell script is;
-- import <module name>

-- This must be done before defining any functions,
-- so imports are usually done at the top of the file.

-- Load all functions that Data.List exports;

import Data.List

-- When you do import Data.List, all the functions that Data.List exports become
-- available in the global namespace, meaning that you can call them from wherever in the script.

-- You can also selectively import a few functions you want;

import Data.List (nub, sort)

-- You can also choose to import all of the functions of a module except a few select ones.
-- This is usefult when a couple of modules exports functions with same name.

import Data.List hiding (sort)

-- Another way of dealing with name clashes is to do qualified imports.
-- The Data.Map module, which offers a data structure for looking up values by key,
-- exports a bunch of functions with the same name as Prelude functions, like filter or null.
-- So when we import Data.Map and then call filter, Haskell won't know which function to use.
-- So we using qualified imports which makes it so that if we want to reference Data.Map's
-- filter function, we have to do Data.Map.filter, whereas just filter still refers to
-- the normal filter we all know and love.

import qualified Data.Map

-- We can also rename the qualified import to something shorter for easy usage;

import qualified Data.Map as M

-- Now we can reference Data.Map.filter as M.filter

-- nub is one of them.
-- nub takes a list and returns new list without duplicates.
numUniques :: (Eq a) => [a] -> Int
numUniques = length . nub

-- Haskell modules index;
-- https://downloads.haskell.org/~ghc/latest/docs/html/libraries/

-- Search engine for searching Haskell functions or to find out where they're located;
-- https://www.haskell.org/hoogle/
