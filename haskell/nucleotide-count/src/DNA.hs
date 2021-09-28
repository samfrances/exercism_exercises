module DNA (nucleotideCounts, Nucleotide(..)) where

import Data.Map (Map, fromListWith)

data Nucleotide = A | C | G | T deriving (Eq, Ord, Show)

nucleotideCounts :: String -> Either String (Map Nucleotide Int)
nucleotideCounts xs = count <$> dnaFromString xs

    where count :: [Nucleotide] -> Map Nucleotide Int
          count = fromListWith (+) . map (\n -> (n, 1))

          dnaFromString :: String -> Either String [Nucleotide]
          dnaFromString = traverse nucleotideFromChar

          nucleotideFromChar :: Char -> Either String Nucleotide
          nucleotideFromChar 'A' = Right A
          nucleotideFromChar 'C' = Right C
          nucleotideFromChar 'G' = Right G
          nucleotideFromChar 'T' = Right T
          nucleotideFromChar x = Left [x]



