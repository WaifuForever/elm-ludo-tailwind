module HomeBox exposing (homeBox)

import Cell exposing (homeCell, playerColourToString)
import Html exposing (..)
import Html.Attributes exposing (..)
import LudoModel exposing (PlayerColour(..))


homeBox : List Bool -> PlayerColour -> Html msg
homeBox pieces colour =
    div [ class ("flex w-96 h-96 justify-center items-center bg-" ++ playerColourToString colour ++ "-700") ]
        [ div [ class "flex w-60 h-60 flex-wrap justify-center items-center rounded-xl p-8 bg-white" ]
            (List.map (\x -> homeCell x colour) pieces)
        ]
