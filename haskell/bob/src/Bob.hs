module Bob (responseFor) where

import Data.Char (isSpace, toUpper, isAlpha)
import Data.List (dropWhileEnd)

responseFor :: String -> String
responseFor = responseFor' . processComment

responseFor' :: ProcessedComment -> String
responseFor' comment
    | isSilence comment        = "Fine. Be that way!"
    | isQuestion comment       =
        if isShouting comment
            then "Calm down, I know what I'm doing!"
            else "Sure."
    | isShouting comment       = "Whoa, chill out!"
    | otherwise                = "Whatever."
    where
        isQuestion (ProcessedComment ('?':_)) = True
        isQuestion (ProcessedComment _) = False
        isSilence (ProcessedComment "") = True
        isSilence (ProcessedComment _)  = False
        isShouting (ProcessedComment c) =
            (map toUpper c) == c && (any isAlpha c)

data ProcessedComment = ProcessedComment String
processComment :: String -> ProcessedComment
processComment = ProcessedComment . reverse . trim

trim :: String -> String
trim = dropWhileEnd isSpace . dropWhile isSpace
