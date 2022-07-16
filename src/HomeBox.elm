module HomeBox exposing (homeBox)

import Html exposing (..)
import Html.Attributes exposing (..)
import LudoModel exposing (PlayerColor(..))


homeBox : String -> PlayerColor -> Html msg
homeBox className color =
    let
        computedClassName =
            (case color of
                Red ->
                    "-red-700"

                Green ->
                    "-green-700"

                Blue ->
                    "-blue-700"

                Yellow ->
                    "-yellow-700"
            )
                ++ className
    in
    div [ class ("flex w-96 h-96 m-3 justify-center items-center bg" ++ computedClassName) ]
        [ div [ class "flex w-60 h-60 flex-wrap justify-center items-center rounded-xl p-8 bg-white" ]
            [ div [ class ("w-16 h-16 m-2 rounded-full bg-gray-300 border" ++ computedClassName) ] []
            , div [ class ("w-16 h-16 m-2 rounded-full bg-gray-300 border" ++ computedClassName) ] []
            , div [ class ("w-16 h-16 m-2 rounded-full bg-gray-300 border" ++ computedClassName) ] []
            , div [ class ("w-16 h-16 m-2 rounded-full bg-gray-300 border" ++ computedClassName) ] []
            ]
        ]
