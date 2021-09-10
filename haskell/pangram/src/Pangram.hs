module Pangram (isPangram) where

import Data.List (sort, group)
import Data.Char (toLower)

isPangram :: String -> Bool
isPangram text =
    (countUniqueLetters text) >= 26
    where countUniqueLetters = length . unique . alphaLetters
          unique = map head . group . sort
          alphaLetters = filter isAlpha . map toLower
          isAlpha = (`elem` alphabet)
          alphabet = "abcdefghijklmnopqrstuvwxyz"
