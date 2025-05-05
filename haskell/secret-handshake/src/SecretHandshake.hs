module SecretHandshake (handshake) where

import Data.Bits

handshake :: Int -> [String]
handshake n = foldr (.) id (getActions n) $ []

type ActionFn = [String] -> [String]

getActions :: Int -> [ActionFn]
getActions n = (orderActions n):commandActionFns
                where commandActionFns = map (prependCommandAction n) $ reverse [0..3]

prependCommandAction :: Int -> Int -> ActionFn
prependCommandAction n actionBit actions = if testBit n actionBit then action:actions else actions
                                where action = ["wink", "double blink", "close your eyes", "jump"] !! actionBit

orderActions :: Int -> ActionFn
orderActions n actions = if (testBit n 4) then actions else reverse actions




