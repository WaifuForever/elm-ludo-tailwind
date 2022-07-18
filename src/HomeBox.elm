module HomeBox exposing (homeBox)

import Cell exposing (homeCell)
import Html exposing (..)
import Html.Attributes exposing (..)
import LudoModel exposing (PlayerColour(..))


homeBox : List Bool -> PlayerColour -> Html msg
homeBox pieces colour =
    let
        computedClassName =
            case colour of
                Red ->
                    "Red"

                Green ->
                    "Green"

                Blue ->
                    "Blue"

                Yellow ->
                    "Yellow"
    in
    div [ class ("flex w-96 h-96 justify-center items-center bg-" ++ String.toLower computedClassName ++ "-700") ]
        [ div [ class "flex w-60 h-60 flex-wrap justify-center items-center rounded-xl p-8 bg-white" ]
            (List.map (\x -> homeCell x computedClassName) pieces)
        ]
