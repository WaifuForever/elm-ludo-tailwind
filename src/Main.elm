module Main exposing (main)

import Array exposing (Array)
import Browser
import Cell exposing (sharedCell)
import Dice exposing (dice)
import HomeBox exposing (homeBox)
import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (Model, Msg(..), PlayerColour(..), Position(..))
import Update exposing (update)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        []


main : Program () Model Msg
main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }


state : List PlayerColour
state =
    [ Blue, Yellow, Red, Green ]


init : () -> ( Model, Cmd Msg )
init _ =
    ( { diceNum = Just 2
      , diceAnimation = False
      , positions = []
      , maxPlayers = Just 2
      , room = Nothing
      , roomToJoin = ""
      , messageToDisplay = ""
      , participants = [ Red, Green, Yellow, Blue ]
      }
    , Cmd.none
    )


getElementFromList : Int -> List a -> Maybe a
getElementFromList index list =
    case ( list, index ) of
        ( [], _ ) ->
            Nothing

        ( [ a ], i ) ->
            if index == 0 then
                Just a

            else
                Nothing

        ( xs, i ) ->
            if index == 0 then
                List.head xs

            else
                getElementFromList
                    (i - 1)
                    (case List.tail xs of
                        Nothing ->
                            []

                        Just xs1 ->
                            xs1
                    )


checkPlayers : List ( List PlayerColour, Int ) -> List Int -> PlayerColour -> Int -> ( List PlayerColour, Int )
checkPlayers xxs ys colour index =
    let
        n =
            case getElementFromList index ys of
                Nothing ->
                    -1

                Just n1 ->
                    n1
    in
    case
        List.head
            (List.filter
                (\( xs, y ) ->
                    y == n
                )
                xxs
            )
    of
        Nothing ->
            ( [], n )

        Just x ->
            x


lineHtml : Model -> PlayerColour -> String -> Int -> List Int -> Html Msg
lineHtml model colour direction id positions =
    case id of
        0 ->
            div [ class ("flex border flex-" ++ direction) ]
                [ sharedCell (checkPlayers model.positions positions colour 0) Nothing Nothing
                , sharedCell (checkPlayers model.positions positions colour 1) (Just colour) (Just "-700")
                , sharedCell (checkPlayers model.positions positions colour 2) Nothing Nothing
                , sharedCell (checkPlayers model.positions positions colour 3) Nothing Nothing
                , sharedCell (checkPlayers model.positions positions colour 4) Nothing Nothing
                , sharedCell (checkPlayers model.positions positions colour 5) Nothing Nothing
                ]

        1 ->
            div [ class ("flex border flex-" ++ direction) ]
                [ sharedCell (checkPlayers model.positions positions colour 0) Nothing Nothing
                , sharedCell (checkPlayers model.positions positions colour 1) (Just colour) (Just "-700")
                , sharedCell (checkPlayers model.positions positions colour 2) (Just colour) (Just "-700")
                , sharedCell (checkPlayers model.positions positions colour 3) (Just colour) (Just "-700")
                , sharedCell (checkPlayers model.positions positions colour 4) (Just colour) (Just "-700")
                , sharedCell (checkPlayers model.positions positions colour 5) (Just colour) (Just "-700")
                ]

        2 ->
            div [ class ("flex border flex-" ++ direction) ]
                [ sharedCell (checkPlayers model.positions positions colour 0) Nothing Nothing
                , sharedCell (checkPlayers model.positions positions colour 1) Nothing Nothing
                , sharedCell (checkPlayers model.positions positions colour 2) Nothing Nothing
                , sharedCell (checkPlayers model.positions positions colour 3) Nothing Nothing
                , sharedCell (checkPlayers model.positions positions colour 4) (Just colour) (Just "-700")
                , sharedCell (checkPlayers model.positions positions colour 5) Nothing Nothing
                ]

        3 ->
            div [ class ("flex border flex-" ++ direction) ]
                [ sharedCell (checkPlayers model.positions positions colour 0) (Just colour) (Just "-700")
                , sharedCell (checkPlayers model.positions positions colour 1) (Just colour) (Just "-700")
                , sharedCell (checkPlayers model.positions positions colour 2) (Just colour) (Just "-700")
                , sharedCell (checkPlayers model.positions positions colour 3) (Just colour) (Just "-700")
                , sharedCell (checkPlayers model.positions positions colour 4) (Just colour) (Just "-700")
                , sharedCell (checkPlayers model.positions positions colour 5) Nothing Nothing
                ]

        _ ->
            div [ class ("flex border flex-" ++ direction) ]
                [ sharedCell (checkPlayers model.positions positions colour 0) Nothing Nothing
                , sharedCell (checkPlayers model.positions positions colour 1) Nothing Nothing
                , sharedCell (checkPlayers model.positions positions colour 2) Nothing Nothing
                , sharedCell (checkPlayers model.positions positions colour 3) Nothing Nothing
                , sharedCell (checkPlayers model.positions positions colour 4) Nothing Nothing
                , sharedCell (checkPlayers model.positions positions colour 5) Nothing Nothing
                ]


isNot : Bool -> Maybe Bool
isNot b =
    if b then
        Just (not b)

    else
        Nothing


sparePieces : List ( List PlayerColour, Int ) -> PlayerColour -> List Bool
sparePieces inGame playerColour =
    List.filterMap isNot (List.map (\( x, _ ) -> List.member playerColour x) inGame)


gridHtml : Model -> Html Msg
gridHtml model =
    let
        first =
            case getElementFromList 0 state of
                Just x ->
                    x

                Nothing ->
                    Red

        second =
            case getElementFromList 1 state of
                Just x ->
                    x

                Nothing ->
                    Green

        third =
            case getElementFromList 2 state of
                Just x ->
                    x

                Nothing ->
                    Yellow

        fourth =
            case getElementFromList 3 state of
                Just x ->
                    x

                Nothing ->
                    Blue
    in
    div [ class "flex border-2 border-white bg-white rounded-xl" ]
        [ div
            []
            [ homeBox (sparePieces model.positions first) first "rounded-tl-xl"
            , div [ class "col" ]
                [ lineHtml model first "row" 0 (List.reverse (List.range 0 5))
                , lineHtml model first "row" 1 (List.range 6 11)
                , lineHtml model first "row" 4 (List.range 12 17)
                ]
            , homeBox (sparePieces model.positions second) second "rounded-bl-xl"
            ]
        , div
            [ class "col" ]
            [ div [ class "flex" ]
                [ lineHtml model third "col" 4 (List.range 66 71)
                , lineHtml model third "col" 1 (List.range 60 65)
                , lineHtml model third "col" 0 (List.reverse (List.range 54 59))
                ]
            , div [ class "w-48 h-48" ] []
            , div [ class "flex" ]
                [ lineHtml model second "col" 2 (List.range 18 23)
                , lineHtml model second "col" 3 (List.reverse (List.range 24 29))
                , lineHtml model second "col" 4 (List.reverse (List.range 30 35))
                ]
            ]
        , div
            []
            [ homeBox (sparePieces model.positions third) third "rounded-tr-xl"
            , div []
                [ lineHtml model fourth "row" 4 (List.reverse (List.range 48 53))
                , lineHtml model fourth "row" 3 (List.reverse (List.range 42 47))
                , lineHtml model fourth "row" 2 (List.range 36 41)
                ]
            , homeBox (sparePieces model.positions fourth) fourth "rounded-br-xl"
            ]
        ]


gameStartView model =
    div [ class " w-10 w-full  " ]
        []


view : Model -> Html Msg
view model =
    let
        head =
            case List.head model.participants of
                Just x ->
                    x

                Nothing ->
                    Red
    in
    div [ class "flex h-screen justify-center items-center py-2" ]
        [ div [] [ Html.text model.messageToDisplay ]
        , div [ class "flex items-center h-screen min-w-[100px]" ]
            (if List.member head (List.take 2 state) then
                [ dice model ]

             else
                []
            )
        , case model.room of
            Just _ ->
                div []
                    [ div [ class "text-center text-black" ]
                        [ gridHtml model
                        , Html.text ("Room:  " ++ Maybe.withDefault "" model.room)
                        ]
                    ]

            Nothing ->
                div [ class "flex" ]
                    [ div [ class "flex text-center text-black" ]
                        [ gridHtml model ]
                    ]
        , div [ class "flex items-center h-screen min-w-[100px]" ]
            (if List.member head (List.take 2 state) then
                []

             else
                [ dice model ]
            )
        ]
