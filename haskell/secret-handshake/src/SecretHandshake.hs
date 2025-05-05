module SecretHandshake (handshake) where

import Data.Bits

handshake :: Int -> [String]
handshake n = foldr (.) id (getActions n) $ []

type ActionFn = [String] -> [String]

getActions :: Int -> [ActionFn]
getActions n = [(orderActions n), (jump n), (closeEyes n), (doubleBlink n),  (wink n)]

wink :: Int -> ActionFn
wink n actions = if testBit n 0 then "wink":actions else actions

doubleBlink :: Int -> ActionFn
doubleBlink n actions = if testBit n 1 then "double blink":actions else actions

closeEyes :: Int -> ActionFn
closeEyes n actions = if testBit n 2 then "close your eyes":actions else actions

jump :: Int -> ActionFn
jump n actions = if testBit n 3 then "jump":actions else actions

orderActions :: Int -> ActionFn
orderActions n actions = if (testBit n 4) then actions else reverse actions




