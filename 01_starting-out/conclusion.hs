-- # http://learnyouahaskell.com/starting-out

-- LOAD THIS FILE WITH ":l conclusion" within repl (ghci)
-- and reload with ":r"

-- create list of triple tupple which contains triangle sides for triangles where;
-- + triangle is a right triangle (a^2 + b^2 == c^2)
-- + side is smaller or equal to 10 (c <- [1..10])
-- + side a < side b (a <- [1..b])
-- + side b < side c (hypothenuse) (b <- [1..c])
-- + perimeter of triangle is 24 (a+b+c == 24)
rightTriangles' = [
  (a, b, c) |
  c <- [1..10],
  b <- [1..c],
  a <- [1..b],
  a^2 + b^2 == c^2,
  a+b+c == 24 ]
-- ==> [(6,8,10)]

lc = [ (a,b) | a <- ["a", "b"], b <- [1,2] ]
-- ==> [("a",1),("a",2),("b",1),("b",2)]
