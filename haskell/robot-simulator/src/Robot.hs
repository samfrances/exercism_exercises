module Robot
    ( Bearing(East,North,South,West)
    , bearing
    , coordinates
    , mkRobot
    , move
    ) where

data Bearing = North
             | East
             | South
             | West
             deriving (Eq, Show)

instance Enum Bearing where
    toEnum 0 = North
    toEnum 1 = East
    toEnum 2 = South
    toEnum 3 = West
    toEnum x = toEnum (x `mod` 4)

    fromEnum North = 0
    fromEnum East = 1
    fromEnum South = 2
    fromEnum West = 3

data Robot = Robot { bearing :: Bearing, coordinates :: (Integer, Integer) }

mkRobot :: Bearing -> (Integer, Integer) -> Robot
mkRobot direction coords = Robot direction coords

move :: Robot -> String -> Robot
move robot instructions = foldl executeInstruction robot instructions

executeInstruction :: Robot -> Char -> Robot
executeInstruction (Robot b coords) 'A' = Robot b $ addVector coords (unitVector b)
executeInstruction (Robot b coords) 'R' = Robot (succ b) coords
executeInstruction (Robot b coords) 'L' = Robot (pred b) coords
executeInstruction _ _ = error "Unrecognized command"


unitVector :: Bearing -> (Integer, Integer)
unitVector North = (0, 1)
unitVector East  = (1, 0)
unitVector South = (0, -1)
unitVector West  = (-1, 0)

addVector :: (Integer, Integer) -> (Integer, Integer) -> (Integer, Integer)
addVector (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)
