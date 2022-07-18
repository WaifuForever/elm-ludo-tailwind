module Cell exposing (cell, homeCell, playerColourToString, safeCell)

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


pieceSvg : ( PlayerColour, Float ) -> Html msg
pieceSvg ( playerColour, scale ) =
    svg
        [ Svg.Attributes.viewBox ("-10 -5 " ++ String.fromFloat (20 + scale * 10) ++ " " ++ String.fromFloat (20 + scale * 10))
        , Svg.Attributes.width "100%"
        , Svg.Attributes.height "100%"
        , Svg.Attributes.scale (String.fromFloat scale)
        ]
        [ Svg.polyline
            [ Svg.Attributes.points "-5,15 2,5 9,15 -5,15"
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


cell : Maybe PlayerColour -> Maybe PlayerColour -> Maybe String -> Html msg
cell playerColour background opacity =
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

            Just p1 ->
                pieceSvg ( p1, 1 )
        ]


safeCell : List PlayerColour -> PlayerColour -> Maybe String -> Html msg
safeCell pieces colour opacity =
    case pieces of
        [] ->
            cell Nothing (Just colour) opacity

        [ playerColour ] ->
            cell (Just playerColour) (Just playerColour) opacity

        pcs ->
            div
                [ class
                    ("flex flex-wrap w-16 h-16 border border-black bg-"
                        ++ playerColourToString colour
                        ++ (case opacity of
                                Nothing ->
                                    ""

                                Just op ->
                                    op
                           )
                    )
                ]
                [ div [ class "flex flex-col justify-center w-16 h-16 -gap-2" ]
                    (case List.length pieces of
                        2 ->
                            [ div [ class "flex" ]
                                (List.map (\x -> pieceSvg ( x, 0.4 )) pieces)
                            ]

                        3 ->
                            [ div [ class "flex" ]
                                (List.map (\x -> pieceSvg ( x, 0.4 )) (List.take 2 pieces))
                            , div [ class "flex h-8" ]
                                (List.map (\x -> pieceSvg ( x, 0.4 )) (List.drop 2 pieces))
                            ]

                        4 ->
                            [ div [ class "flex" ]
                                (List.map (\x -> pieceSvg ( x, 0.4 )) (List.take 2 pieces))
                            , div [ class "flex" ]
                                (List.map (\x -> pieceSvg ( x, 0.4 )) (List.drop 2 pieces))
                            ]

                        _ ->
                            []
                    )
                ]


homeCell : Bool -> PlayerColour -> Html msg
homeCell p colour =
    div [ class "flex w-16 h-16 m-2 pl-2 pt-1 rounded-full bg-gray-300" ]
        [ if p then
            pieceSvg ( colour, 0.9 )

          else
            div [] []
        ]
