module DNA (toRNA) where

toRNA :: String -> Either Char String
toRNA = traverse translate
    where translate 'G' = Right 'C'
          translate 'C' = Right 'G'
          translate 'T' = Right 'A'
          translate 'A' = Right 'U'
          translate x = Left x