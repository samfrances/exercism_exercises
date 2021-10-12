module Pangram (isPangram) where

import Data.Char (toLower)
import Data.Set (isSubsetOf)
import qualified Data.Set as Set

isPangram :: String -> Bool
isPangram text = alphabet `isSubsetOf` letters
    where letters = Set.fromList . map toLower $ text
          alphabet = Set.fromList ['a'..'z']
