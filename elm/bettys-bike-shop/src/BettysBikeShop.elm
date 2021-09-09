module BettysBikeShop exposing (penceToPounds, poundsToString)

penceToPounds : Int -> Float
penceToPounds pence = toFloat pence / 100

poundsToString : Float -> String
poundsToString pounds = String.join "" ["£", String.fromFloat pounds]
