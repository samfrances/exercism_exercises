module LuciansLusciousLasagna exposing (elapsedTimeInMinutes, expectedMinutesInOven, preparationTimeInMinutes)
expectedMinutesInOven : Int
expectedMinutesInOven = 40

preparationTimeInMinutes : Int -> Int
preparationTimeInMinutes nLayers =
    let minsPerLayer = 2
    in nLayers * minsPerLayer

elapsedTimeInMinutes : Int -> Int -> Int
elapsedTimeInMinutes nLayers minsAlreadyInOven =
    preparationTimeInMinutes nLayers + minsAlreadyInOven
