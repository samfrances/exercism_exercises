module Pangram (isPangram) where

import Data.List (sort, group)
import Data.Char (toLower)

isPangram :: String -> Bool
isPangram text =
    (length . unique . letters $ text) >= 26
    where unique = map head . group . sort
          letters = filter isAlpha . map toLower
          isAlpha = (`elem` ['a'..'z'])
