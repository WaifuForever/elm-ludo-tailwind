module Cell exposing (cell, safeCell, homeCell)

import Html exposing (Html, div)
import Html.Attributes exposing (class)
import LudoModel exposing (PlayerColour(..))
import Svg
import Svg.Attributes


pieceSvg : ( String, Int ) -> Html msg
pieceSvg ( colour, scale ) =
    Svg.circle
        [ Svg.Attributes.cx (String.fromInt (50 + scale * 10))
        , Svg.Attributes.cy (String.fromInt (50 + scale * 10))
        , Svg.Attributes.r (String.fromInt 45)
        , Svg.Attributes.stroke "black"
        , Svg.Attributes.strokeWidth "1"
        , Svg.Attributes.fill colour
        ]
        []


cell : Maybe Int -> String -> Html msg
cell piece colour =
    div [ class ("w-16 h-16 border border-black bg-" ++ colour ++ "-100") ]
        [ case piece of
            Nothing ->
                div [] []

            Just p1 ->
                pieceSvg ( colour, p1 )
        ]


safeCell : List Int -> String -> Html msg
safeCell pieces colour =
    case pieces of
        [] ->
            cell Nothing colour

        [ scale ] ->
            cell (Just scale) colour

        ps ->
            div [] []


homeCell : Bool -> String -> Html msg
homeCell p colour =
    div [ class ("w-16 h-16 m-2 rounded-full bg-gray-300 border-r " ++ colour) ]
        [ if p then
            pieceSvg ( colour, 10 )

          else
            div [] []
        ]
