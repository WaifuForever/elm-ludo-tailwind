module Dice exposing (dice)

import Html exposing (Html, button, div, img, text)
import Html.Attributes exposing (class, hidden)
import Html.Events exposing (onClick)
import Model exposing (Model, Msg(..), PlayerColour(..))
import Svg exposing (svg)
import Svg.Attributes


diceFace : Bool -> Int -> ( Int, Int ) -> Html Msg
diceFace isMoving number ( x, y ) =
    let
        viewBoxConstraints =
            "0 0 " ++ String.fromInt y ++ " " ++ String.fromInt x

        colour =
            if isMoving then
                "currentColor"

            else
                "red"
    in
    case number of
        1 ->
            svg
                [ Svg.Attributes.viewBox viewBoxConstraints
                , Svg.Attributes.height "100%"
                , Svg.Attributes.width "100%"
                , Svg.Attributes.fill colour
                ]
                [ Svg.circle
                    [ Svg.Attributes.cx "8"
                    , Svg.Attributes.cy "8"
                    , Svg.Attributes.r (String.fromInt (y // 10))
                    , Svg.Attributes.stroke colour
                    , Svg.Attributes.strokeWidth "1"
                    ]
                    []
                , Svg.path
                    [ Svg.Attributes.d "M13 1a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h10zM3 0a3 3 0 0 0-3 3v10a3 3 0 0 0 3 3h10a3 3 0 0 0 3-3V3a3 3 0 0 0-3-3H3z"
                    ]
                    []
                ]

        2 ->
            svg
                [ Svg.Attributes.viewBox viewBoxConstraints
                , Svg.Attributes.height "100%"
                , Svg.Attributes.width "100%"
                , Svg.Attributes.fill colour
                ]
                [ Svg.path
                    [ Svg.Attributes.d "M13 1a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h10zM3 0a3 3 0 0 0-3 3v10a3 3 0 0 0 3 3h10a3 3 0 0 0 3-3V3a3 3 0 0 0-3-3H3z"
                    ]
                    []
                , Svg.path
                    [ Svg.Attributes.d "M5.5 4a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm8 8a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"
                    ]
                    []
                ]

        3 ->
            svg
                [ Svg.Attributes.viewBox viewBoxConstraints
                , Svg.Attributes.height "100%"
                , Svg.Attributes.width "100%"
                , Svg.Attributes.fill colour
                ]
                [ Svg.path
                    [ Svg.Attributes.d "M13 1a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h10zM3 0a3 3 0 0 0-3 3v10a3 3 0 0 0 3 3h10a3 3 0 0 0 3-3V3a3 3 0 0 0-3-3H3z"
                    ]
                    []
                , Svg.path
                    [ Svg.Attributes.d "M5.5 4a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm8 8a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm-4-4a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"
                    ]
                    []
                ]

        4 ->
            svg
                [ Svg.Attributes.viewBox viewBoxConstraints
                , Svg.Attributes.height "100%"
                , Svg.Attributes.width "100%"
                , Svg.Attributes.fill colour
                ]
                [ Svg.path
                    [ Svg.Attributes.d "M13 1a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h10zM3 0a3 3 0 0 0-3 3v10a3 3 0 0 0 3 3h10a3 3 0 0 0 3-3V3a3 3 0 0 0-3-3H3z"
                    ]
                    []
                , Svg.path
                    [ Svg.Attributes.d "M5.5 4a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm8 0a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0 8a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm-8 0a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"
                    ]
                    []
                ]

        5 ->
            svg
                [ Svg.Attributes.viewBox viewBoxConstraints
                , Svg.Attributes.height "100%"
                , Svg.Attributes.width "100%"
                , Svg.Attributes.fill colour
                ]
                [ Svg.path
                    [ Svg.Attributes.d "M13 1a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h10zM3 0a3 3 0 0 0-3 3v10a3 3 0 0 0 3 3h10a3 3 0 0 0 3-3V3a3 3 0 0 0-3-3H3z"
                    ]
                    []
                , Svg.path
                    [ Svg.Attributes.d "M5.5 4a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm8 0a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0 8a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm-8 0a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm4-4a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"
                    ]
                    []
                ]

        _ ->
            svg
                [ Svg.Attributes.viewBox viewBoxConstraints
                , Svg.Attributes.height "100%"
                , Svg.Attributes.width "100%"
                , Svg.Attributes.fill colour
                ]
                [ Svg.path
                    [ Svg.Attributes.d "M13 1a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h10zM3 0a3 3 0 0 0-3 3v10a3 3 0 0 0 3 3h10a3 3 0 0 0 3-3V3a3 3 0 0 0-3-3H3z"
                    ]
                    []
                , Svg.path
                    [ Svg.Attributes.d "M5.5 4a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm8 0a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0 8a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-4a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm-8 4a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-4a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"
                    ]
                    []
                ]


dice : Model -> Html Msg
dice model =
    div [ class "w-40 h-40 overflow-hidden", onClick Roll ]
        [ diceFace model.diceAnimation
            (case model.diceNum of
                Just n ->
                    n

                Nothing ->
                    2
            )
            ( 16, 16 )
        ]
