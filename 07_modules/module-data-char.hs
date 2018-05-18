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

-- The Data.Char also exports the GeneralCategory type which is an enumeration.
-- It presents us with a few possible categories that a character can fall into.
-- The main function for getting the general category of a character is generalCategory.
-- It has a type of generalCategory :: Char -> GeneralCategory.
-- There are about 31 categories so we won't list them all here

-- Since the GeneralCategory type is part of the Eq typeclass,
-- we can also test for stuff like generalCategory c == Space

-- Lets implement our own isSpace.
isSpace' :: Char -> Bool
isSpace' c = generalCategory c == Space
-- => isSpace' ' '
-- ==> True
-- => isSpace' 'k'
-- ==> False

-- CONVERTINGS

-- > toUpper
-- converts a character to upper-case. Spaces, numbers, and the like remain unchanged.

-- > toLower
-- converts a character to lower-case.

-- > toTitle
-- converts a character to title-case. For most characters, title-case is the same as upper-case.

-- > digitToInt
-- converts a character to an Int. To succeed, the character must be in the
-- ranges '0'..'9', 'a'..'f' or 'A'..'F'.

-- > intToDigit
-- is the inverse function of digitToInt. It takes an Int in the range of 0..15
-- and converts it to a lower-case character.

-- > ord & chr
-- functions convert characters to their corresponding numbers and vice versa
-- => ord 'a'
-- ==> 97
-- => chr 97
-- ==> 'a'
-- The difference between the ord values of two characters is equal to how
-- far apart they are in the Unicode table.

-- The Caesar cipher is a primitive method of encoding messages by shifting each
-- character in them by a fixed number of positions in the alphabet.
-- We can easily create a sort of Caesar cipher of our own, only we won't
-- constrict ourselves to the alphabet.
encode :: Int -> String -> String
encode shift msg =
    let ords = map ord msg
        shifted = map (+ shift) ords
    in  map chr shifted
-- => encode 5 "Marry Christmas! Ho ho ho!"
-- ==> "Rfww~%Hmwnxyrfx&%Mt%mt%mt&"
-- you can also write this with composition as;
encode' :: Int -> String -> String
encode' shift msg = map (chr . (+ shift) . ord) msg
--  Decoding a message is basically just shifting it back by
-- the number of places it was shifted by in the first place.
decode :: Int -> String -> String
decode shift msg = encode (negate shift) msg
-- => decode 5 "Rfww~%Hmwnxyrfx&%Mt%mt%mt&"
-- ==> "Marry Christmas! Ho ho ho!"
