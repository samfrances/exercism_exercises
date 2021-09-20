module CollatzConjecture (collatz) where

collatz :: Integer -> Maybe Integer
collatz n
    | n > 0     = Just (collatzCount n)
    | otherwise = Nothing

collatzCount :: Integer -> Integer
collatzCount = fromIntegral . length . collatzSeq

collatzSeq :: Integer -> [Integer]
collatzSeq = takeWhile (> 1) . iterate collatzStep

collatzStep :: Integer -> Integer
collatzStep n
    | even n = n `div` 2
    | otherwise = (n * 3) + 1
