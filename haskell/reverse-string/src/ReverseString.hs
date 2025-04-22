module ReverseString (reverseString) where

reverseString :: String -> String
reverseString str = foldl (\acc c -> c:acc) "" str
