module SumOfMultiples (sumOfMultiples) where

import Data.List

sumOfMultiples :: [Integer] -> Integer -> Integer
sumOfMultiples factors limit =
    sum $ nub $ multiples =<< factors
    where multiples 0 = []
          multiples n = [n,n+n..limit-1]
