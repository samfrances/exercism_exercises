module Pangram (isPangram) where

import Data.List (sort, group)
import Data.Char (toLower)

isPangram :: String -> Bool
isPangram text =
    (getLetters text) == alphabet
    where getLetters = map head . group . sort . filter (`elem` alphabet) . map toLower
          alphabet = "abcdefghijklmnopqrstuvwxyz"
