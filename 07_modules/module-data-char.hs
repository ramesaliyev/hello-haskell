-- # http://learnyouahaskell.com/modules#data-char

-- LOAD THIS FILE WITH ":l module-data-char" within repl (ghci)
-- and reload with ":r"

import Data.Char
import Data.List
import Data.Function

-- It exports functions that deal with characters.
-- It's also helpful when filtering and mapping over strings
-- because they're just lists of characters.

-- PREDICATES

-- There are predicate functions over characters that take a character and
-- tell us whether some assumption about it is true or false.
-- Predicates have Char -> Bool signature.

-- > isControl
-- checks whether a character is a control character.

-- > isSpace
-- checks whether a character is a white-space characters.
-- That includes spaces, tab characters, newlines, etc.

-- > isLower
-- checks whether a character is lower-cased.

-- > isUpper
-- checks whether a character is upper-cased.

-- > isAlpha
-- checks whether a character is a letter.

-- > isAlphaNum
-- checks whether a character is a letter or a number.

-- > isPrint
-- checks whether a character is printable.
-- Control characters, for instance, are not printable.

-- > isDigit
-- checks whether a character is a digit.

-- > isOctDigit
-- checks whether a character is an octal digit.

-- > isHexDigit
-- checks whether a character is a hex digit.

-- > isLetter
-- checks whether a character is a letter.

-- > isMark
-- checks for Unicode mark characters. Those are characters that combine with
-- preceding letters to form latters with accents. Use this if you are French.

-- > isNumber
-- checks whether a character is numeric.

-- > isPunctuation
-- checks whether a character is punctuation.

-- > isSymbol
-- checks whether a character is a fancy mathematical or currency symbol.

-- > isSeparator
-- checks for Unicode spaces and separators.

-- > isAscii
-- checks whether a character falls into the first 128 characters of the Unicode character set.

-- > isLatin1
-- checks whether a character falls into the first 256 characters of Unicode.

-- > isAsciiUpper
-- checks whether a character is ASCII and upper-case.

-- > isAsciiLower
-- checks whether a character is ASCII and lower-case.

-- examples;

isAllAlphaNum :: [Char] -> Bool
isAllAlphaNum = all isAlphaNum
-- => isAllAlphaNum "bobby283"
-- ==> True
-- => isAllAlphaNum "eddy the fish!"
-- ==> True

words' :: [Char] -> [[Char]]
words' x = filter (not . any isSpace) . groupBy ((==) `on` isSpace) $ x
-- => words' "hello guys whatsup"
-- ==> ["hello"," ","guys"," ","whatsup"]

