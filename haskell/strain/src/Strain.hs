module Strain (keep, discard) where

discard :: (a -> Bool) -> [a] -> [a]
discard _p [] = []
discard p (x:xs) =
    if p x then rest else x:rest
    where rest = discard p xs

keep :: (a -> Bool) -> [a] -> [a]
keep p = discard $ opposite p

opposite :: (a -> Bool) -> (a -> Bool)
opposite p x = not (p x)
