module HomeBox exposing (homeBox)

import Cell exposing (homeCell, playerColourToString)
import Html exposing (..)
import Html.Attributes exposing (..)
import LudoModel exposing (PlayerColour(..))


homeBox : List Bool -> PlayerColour -> String -> Html msg
homeBox pieces colour rounded =
    div [ class ("flex w-96 h-96 justify-center items-center bg-" ++ playerColourToString colour ++ "-700 " ++ rounded) ]
        [ div [ class "flex w-60 h-60 flex-wrap justify-center items-center rounded-xl p-8 bg-white" ]
            (List.map (\x -> homeCell x colour)
                (List.concat [ List.take (4 - List.length pieces) [ True, True, True, True ], pieces ])
            )
        ]
