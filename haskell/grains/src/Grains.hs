module Grains (square, total) where

square :: Integer -> Maybe Integer
square n | n < 1     = Nothing
         | n > 64    = Nothing
         | otherwise = Just (2 ^ (n-1))


total :: Integer
total = case maybeSum of
    Just x -> x
    Nothing -> 0
    where maybeSum = sum <$> sequence [square x | x <- [1..64]]
