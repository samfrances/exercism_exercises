module SumOfMultiples (sumOfMultiples) where

import qualified Data.Set as Set
import Data.Set (unions)

sumOfMultiples :: [Integer] -> Integer -> Integer
sumOfMultiples factors limit =
    sum $ combinedMultiples factors limit

combinedMultiples :: [Integer] -> Integer -> Set.Set Integer
combinedMultiples factors limit =
    unions $ map Set.fromList $ map (multiples limit) factors

multiples :: Integer -> Integer -> [Integer]
multiples _limit 0 = [0]
multiples limit n = [n,n+n..limit-1]
