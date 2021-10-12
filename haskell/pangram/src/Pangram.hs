module Pangram (isPangram) where

import Data.Char (toLower)
import qualified Data.Set as Set

isPangram :: String -> Bool
isPangram text =
    (length . Set.fromList . letters $ text) >= 26
    where letters = filter isAlpha . map toLower
          isAlpha = (`elem` ['a'..'z'])
