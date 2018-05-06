-- # http://learnyouahaskell.com/syntax-in-functions#let-it-be

-- LOAD THIS FILE WITH ":l let" within repl (ghci)
-- and reload with ":r"

-- Let bindings let you bind to variables anywhere and are expressions themselves,
-- but are very local, so they don't span across guards.

-- A function that gives us a cylinder's surface area based on its height and radius:
cylinder :: (RealFloat a) => a -> a -> a  
cylinder r h = 
    let sideArea = 2 * pi * r * h  
        topArea = pi * r ^2  
    in  sideArea + 2 * topArea 

-- The form is let <bindings> in <expression>.

-- The names that you define in the let part are accessible to the expression after the in part.

-- Difference between let and where is let puts the bindings first and the expression that
-- uses them later whereas where is the other way around.

-- While where bindings are just syntactic constructs,
-- let bindings are expressions themselves.

-- Because it is a expression, it can be used (like if else expressions) anywhere where
-- a value is expected.
-- => 4 * (let a = 9 in a + 1) + 2
-- ==> 42

-- They can also be used to introduce functions in local scope.
-- => [let square x = x * x in (square 5, square 3, square 2)]
-- ==> [(25,9,4)]

-- If we want to bind to several variables inline, we can separate them with semicolons.
-- Create tuple with two element..
dynamicTuple = (let a = 100; b = 200; c = 300 in a*b*c, let foo="Hey "; bar = "there!" in foo ++ bar)
-- => dynamicTuple
-- ==> (6000000, "Hey there!")
-- You don't have to put a semicolon after the last binding but you can if you want.

-- Just like any construct in Haskell that is used to bind values to names,
-- let bindings can be used for pattern matching.
patternMatch = (let (a,b,c) = (1,2,3) in a+b+c) * 100
-- => patternMatch
-- ==> 600

-- You can also put let bindings inside list comprehensions.
-- So instead of writing with where like this;
calcBmisWWhere :: (RealFloat a) => [(a, a)] -> [a]
calcBmisWWhere xs = [bmi w h | (w, h) <- xs]
    where bmi weight height = weight / height ^ 2
-- We can use let like this;
calcBmis :: (RealFloat a) => [(a, a)] -> [a]  
calcBmis xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2]
-- We include a let inside a list comprehension much like we would a predicate,
-- only it doesn't filter the list, it only binds to names. The names defined in a
-- let inside a list comprehension are visible to the output function (the part before the |)
-- and all predicates and sections that come after of the binding.
-- So we could make our function return only the BMIs of fat people:
getFats :: (RealFloat a) => [(a, a)] -> [a]  
getFats xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2, bmi >= 25.0]  
-- We can't use the bmi name in the (w, h) <- xs part because it's defined prior to the let binding.
-- We omitted the in part of the let binding when we used them in list comprehensions because
-- the visibility of the names is already predefined there.
-- However, we could use a let in binding in a predicate and the names defined would only be visible to that predicate.

-- In part can also be omitted when defining functions and constants directly in GHCi,
-- then the names will be visible throughout the entire interactive session.

-- I think in most cases where is better for functions (if we dont want scoping)
-- because the function body is closer to its name and type declaration and to some that's more readable.
