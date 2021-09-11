module Bob (responseFor) where

import Data.Char (isSpace, toUpper, isAlpha)
import Data.List (dropWhileEnd)

responseFor :: String -> String
responseFor = responseForProcessedComment . processComment

responseForProcessedComment :: String -> String
responseForProcessedComment "" = "Fine. Be that way!"
responseForProcessedComment ('?':rest) = responseForQuestion rest
responseForProcessedComment comment
    | isShouting comment = "Whoa, chill out!"
    | otherwise          = "Whatever."

responseForQuestion :: String -> String
responseForQuestion q
    | isShouting q = "Calm down, I know what I'm doing!"
    | otherwise    = "Sure."

isShouting :: String -> Bool
isShouting comment =
    (map toUpper comment) == comment
    && (any isAlpha comment)


processComment :: String -> String
processComment = reverse . trim

trim :: String -> String
trim = dropWhileEnd isSpace . dropWhile isSpace
