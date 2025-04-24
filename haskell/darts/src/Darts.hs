module Darts (score) where

score :: Float -> Float -> Int
score x y = if distanceFromTarget > 10 then 0 else
            if distanceFromTarget > 5 then 1 else
            if distanceFromTarget > 1 then 5 else 10
    where distanceFromTarget = distance (0, 0) (x, y)

type Pos = (Float, Float)

distance :: Pos -> Pos -> Float
distance (x1, y1) (x2, y2) = sqrt $ (x1 - x2) ** 2 + (y1 - y2) ** 2


