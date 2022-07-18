module Cell exposing (homeCell, playerColourToString, sharedCell, singleCell)

import Html exposing (Html, div)
import Html.Attributes exposing (class)
import LudoModel exposing (PlayerColour(..))
import Svg exposing (svg)
import Svg.Attributes


playerColourToString : PlayerColour -> String
playerColourToString playerColour =
    case playerColour of
        Red ->
            "red"

        Green ->
            "green"

        Yellow ->
            "yellow"

        Blue ->
            "blue"


pieceSvg : ( PlayerColour, Float ) -> Maybe Int -> Html msg
pieceSvg ( playerColour, scale ) deviation =
    svg
        [ Svg.Attributes.viewBox
            (String.fromInt
                (case deviation of
                    Nothing ->
                        -10

                    Just x ->
                        x
                )
                ++ " -5 "
                ++ String.fromFloat (20 + scale * 10)
                ++ " "
                ++ String.fromFloat (20 + scale * 10)
            )
        , Svg.Attributes.width "100%"
        , Svg.Attributes.height "100%"
        , Svg.Attributes.scale (String.fromFloat scale)
        ]
        [ Svg.polyline
            [ Svg.Attributes.points "-4,15 2,5 9,15 -4,15"
            , Svg.Attributes.fill (playerColourToString playerColour)
            , Svg.Attributes.stroke "black"
            , Svg.Attributes.strokeWidth "1"
            ]
            []
        , Svg.circle
            [ Svg.Attributes.cx "2"
            , Svg.Attributes.cy "3"
            , Svg.Attributes.r "4"
            , Svg.Attributes.stroke "black"
            , Svg.Attributes.strokeWidth "1"
            , Svg.Attributes.fill (playerColourToString playerColour)
            ]
            []
        ]


singleCell : Maybe PlayerColour -> Maybe PlayerColour -> Maybe String -> Int -> Html msg
singleCell playerColour background opacity index =
    div
        [ class
            ("w-16 h-16 border border-black bg-"
                ++ (case background of
                        Nothing ->
                            "white"

                        Just bg ->
                            playerColourToString bg
                   )
                ++ (case opacity of
                        Nothing ->
                            ""

                        Just op ->
                            op
                   )
            )
        ]
        [ case playerColour of
            Nothing ->
                div [] []

            Just colour ->
                pieceSvg ( colour, 0.7 ) (Just -11)
        ]


sharedCell : ( List PlayerColour, Int ) -> Maybe PlayerColour -> Maybe String -> Html msg
sharedCell positions background opacity =
    case positions of
        ( [], i ) ->
            singleCell Nothing background opacity i

        ( [ playerColour ], i ) ->
            singleCell (Just playerColour) background opacity i

        ( playerColours, i ) ->
            div
                [ class
                    ("flex flex-wrap w-16 h-16 border border-black bg-"
                        ++ (case background of
                                Nothing ->
                                    ""

                                Just bg ->
                                    playerColourToString bg
                           )
                        ++ (case opacity of
                                Nothing ->
                                    ""

                                Just op ->
                                    op
                           )
                    )
                ]
                [ div [ class "flex flex-col justify-center w-16 h-16 -gap-2" ]
                    (case List.length playerColours of
                        2 ->
                            [ div [ class "flex" ]
                                (List.map (\x -> pieceSvg ( x, 0.4 ) Nothing) playerColours)
                            ]

                        3 ->
                            [ div [ class "flex" ]
                                (List.map (\x -> pieceSvg ( x, 0.4 ) Nothing) (List.take 2 playerColours))
                            , div [ class "flex h-8 -mt-1" ]
                                (List.map (\x -> pieceSvg ( x, 0.4 ) Nothing) (List.drop 2 playerColours))
                            ]

                        4 ->
                            [ div [ class "flex" ]
                                (List.map (\x -> pieceSvg ( x, 0.4 ) Nothing) (List.take 2 playerColours))
                            , div [ class "flex" ]
                                (List.map (\x -> pieceSvg ( x, 0.4 ) Nothing) (List.drop 2 playerColours))
                            ]

                        _ ->
                            []
                    )
                ]


homeCell : Bool -> PlayerColour -> Html msg
homeCell p colour =
    div [ class "flex w-16 h-16 m-2 pl-2 pt-1 rounded-full bg-gray-300" ]
        [ if p then
            pieceSvg ( colour, 0.9 ) Nothing

          else
            div [] []
        ]
