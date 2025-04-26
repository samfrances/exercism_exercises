module Clock (addDelta, fromHourMin, toString) where

import Text.Printf

data Clock = Clock Int Int
  deriving Eq

fromHourMin :: Int -> Int -> Clock
fromHourMin hour min = addDelta hour min $ Clock 0 0

toString :: Clock -> String
toString (Clock hour min) = printf "%02d:%02d" hour min

addDelta :: Int -> Int -> Clock -> Clock
addDelta hour min clock =
  Clock final_hours final_mins
  where (Clock clock_hour clock_min) = clock
        total_mins = (clock_hour + hour) * 60 + clock_min + min
        (rollover_hours, final_mins) = divMod total_mins 60
        final_hours = rollover_hours `mod` 24
