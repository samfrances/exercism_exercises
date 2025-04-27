module Luhn (isValid) where

import Data.Char
import Data.Function
import Data.List

isValid :: String -> Bool
isValid n =
    length (trim n) > 1
    && all isValidChar n
    && score digits `mod` 10 == 0
    where digits = n & filter isDigit & map digitToInt


isValidChar :: Char -> Bool
isValidChar c = isDigit c || isSpace c

enumerate :: [a] -> [(Int, a)]
enumerate xs  = zip [0..] xs

score :: [Int] -> Int
score xs =
    xs & reverse
       & enumerate
       & map updateIndexedDigit
       & map snd
       & sum

updateIndexedDigit :: (Int, Int) -> (Int, Int)
updateIndexedDigit (index, digit)
    | index `mod` 2 == 1 = (index, (updateDigit digit))
    | otherwise = (index, digit)

updateDigit :: Int -> Int
updateDigit n = if doubled < 9 then doubled else doubled_minus_9
    where doubled = n * 2
          doubled_minus_9 = doubled - 9

trim :: [Char] -> [Char]
trim = dropWhileEnd isSpace . dropWhile isSpace