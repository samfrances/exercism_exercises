module Acronym (abbreviate) where

import Data.Char

abbreviate :: String -> String
abbreviate xs = concat . map abbreviateWord . words . replace (`elem` "-_") ' ' $ xs

replace :: Eq a => (a -> Bool) -> a -> [a] -> [a]
replace pred withB inList = map (\c -> if (pred c) then withB else c) inList

abbreviateWord :: String -> String
abbreviateWord w
  | map toUpper w == w = [firstChar]
  | otherwise = firstChar:otherChars
  where firstChar = (toUpper (head w))
        otherChars = filter isUpper (tail w)
