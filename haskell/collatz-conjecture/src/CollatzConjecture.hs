module CollatzConjecture (collatz) where

collatz :: Integer -> Maybe Integer
collatz n
    | n > 0     = Just (collatzCount n 0)
    | otherwise = Nothing

collatzCount :: Integer -> Integer -> Integer
collatzCount 1 count = count
collatzCount n count = collatzCount (collatzStep n) (count + 1)

collatzStep :: Integer -> Integer
collatzStep n
    | even n = n `div` 2
    | otherwise = (n * 3) + 1
