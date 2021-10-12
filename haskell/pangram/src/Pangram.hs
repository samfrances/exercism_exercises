module Pangram (isPangram) where

import Data.Char (toLower)
import qualified Data.Set as Set

isPangram :: String -> Bool
isPangram text =
    (length . letters . Set.fromList $ text) >= 26
    where letters = Set.filter isAlpha . Set.map toLower
          isAlpha = (`elem` ['a'..'z'])
