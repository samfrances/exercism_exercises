module Anagram (anagramsFor) where

import Data.List
import Data.Char

anagramsFor :: String -> [String] -> [String]
anagramsFor xs xss = filter (isAnagramOf xs) xss

isAnagramOf a b = loweredA /= loweredB && normalizedA == normalizedB
  where loweredA = map toLower a
        loweredB = map toLower b
        normalizedA = sort loweredA
        normalizedB = sort loweredB

