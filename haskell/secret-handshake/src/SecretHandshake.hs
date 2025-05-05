module SecretHandshake (handshake) where

import Data.Bits
import Data.Maybe

handshake :: Int -> [String]
handshake n = orderActions n $ mapMaybe (getAction n) [0..3]

getAction :: Int -> Int -> Maybe String
getAction n actionBit = if include then Just action else Nothing
                            where action = actions !! actionBit
                                  actions = ["wink", "double blink", "close your eyes", "jump"]
                                  include = testBit n actionBit

orderActions :: Int -> [String] -> [String]
orderActions n actions = if (shouldReverse n) then reverse actions else actions

shouldReverse :: Int -> Bool
shouldReverse n = testBit n 4



