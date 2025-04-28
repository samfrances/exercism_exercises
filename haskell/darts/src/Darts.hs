module Darts (score) where

score :: Float -> Float -> Int
score x y = distanceToScore $ sqrt $ x ** 2 + y ** 2

distanceToScore :: Float -> Int
distanceToScore dist | dist > 10 = 0
                     | dist > 5  = 1
                     | dist > 1  = 5
                     | otherwise = 10