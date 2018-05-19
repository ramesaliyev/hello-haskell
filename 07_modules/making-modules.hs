-- # http://learnyouahaskell.com/modules#making-our-own-modules

-- LOAD THIS FILE WITH ":l making-modules" within repl (ghci)
-- and reload with ":r"

-- Take a look to Geometry.hs

-- We can only see and use the ones that module exports.

-- import our Geometry module.

import qualified GeometryComplete

-- Geometry.hs has to be in the same folder that the program
-- that's importing it is in, though.

-- Modules can also be given a hierarchical structures.
-- Each module can have a number of sub-modules and they
-- can have sub-modules of their own.

import qualified Geometry.Sphere as Sphere
import qualified Geometry.Cuboid as Cuboid
import qualified Geometry.Cube as Cube

