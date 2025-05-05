module SecretHandshake (handshake) where

import Data.Bits
import Data.List

handshake :: Int -> [String]
handshake n = orderActions n $ unfoldr (getNextAction n) 0


getNextAction :: Int -> Int -> Maybe (String, Int)

getNextAction _ place
    | place > 3 = Nothing
    | place < 0 = Nothing

getNextAction n actionBit = if actionIsSet then Just (action, nextBit) else getNextAction n nextBit
                        where action = actions !! actionBit
                              nextBit = actionBit + 1
                              actionIsSet = testBit n actionBit
                              actions = ["wink", "double blink", "close your eyes", "jump"]


orderActions :: Int -> [String] -> [String]
orderActions n actions = if (shouldReverse n) then reverse actions else actions

shouldReverse :: Int -> Bool
shouldReverse n = testBit n 4