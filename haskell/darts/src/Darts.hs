module Darts (score) where

score :: Float -> Float -> Int
score x y = distanceToScore $ distance bullsEye (x, y)

type Pos = (Float, Float)

bullsEye :: Pos
bullsEye = (0, 0)

distance :: Pos -> Pos -> Float
distance (x1, y1) (x2, y2) = sqrt $ (x1 - x2) ** 2 + (y1 - y2) ** 2

distanceToScore :: Float -> Int
distanceToScore dist | dist > 10 = 0
                     | dist > 5  = 1
                     | dist > 1  = 5
                     | otherwise = 10