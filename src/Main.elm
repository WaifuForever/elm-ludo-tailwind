module Main exposing (main)

import Browser
import Cell exposing (cell, safeCell)
import HomeBox exposing (homeBox)
import Html exposing (..)
import Html.Attributes exposing (..)
import LudoModel exposing (Model, Msg(..), PlayerColour(..), Position(..))
import Random


update : Msg -> Model -> ( Model, Cmd Msg )
update _ model =
    ( model
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        []


main : Program () Model Msg
main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { diceNum = 0
      , turn = Red
      , positions = [ ( Red, 2 ) ]
      , maxPlayers = Just 2
      , room = Nothing
      , roomToJoin = ""
      , messageToDisplay = ""
      , selectedPlayer = Red
      , participants = [ Red, Green, Yellow, Blue ]
      }
    , Cmd.none
    )


lineHtml : PlayerColour -> String -> Int -> Html Msg
lineHtml colour direction id =
    case id of
        0 ->
            div [ class ("flex border flex-" ++ direction) ]
                [ cell Nothing Nothing Nothing
                , safeCell [ Red, Blue ] colour (Just "-700")
                , cell Nothing Nothing Nothing
                , cell Nothing Nothing Nothing
                , cell Nothing Nothing Nothing
                , cell Nothing Nothing Nothing
                ]

        1 ->
            div [ class ("flex border flex-" ++ direction) ]
                [ cell Nothing Nothing Nothing
                , cell Nothing (Just colour) (Just "-700")
                , cell Nothing (Just colour) (Just "-700")
                , cell Nothing (Just colour) (Just "-700")
                , cell Nothing (Just colour) (Just "-700")
                , cell Nothing (Just colour) (Just "-700")
                ]

        2 ->
            div [ class ("flex border flex-" ++ direction) ]
                [ cell Nothing Nothing Nothing
                , cell Nothing Nothing Nothing
                , cell Nothing Nothing Nothing
                , cell Nothing Nothing Nothing
                , safeCell [ Red, Green, Blue ] colour (Just "-700")
                , cell Nothing Nothing Nothing
                ]

        3 ->
            div [ class ("flex border flex-" ++ direction) ]
                [ cell Nothing (Just colour) (Just "-700")
                , cell Nothing (Just colour) (Just "-700")
                , cell Nothing (Just colour) (Just "-700")
                , cell Nothing (Just colour) (Just "-700")
                , cell Nothing (Just colour) (Just "-700")
                , cell Nothing Nothing Nothing
                ]

        _ ->
            div [ class ("flex border flex-" ++ direction) ]
                [ cell Nothing Nothing Nothing
                , cell Nothing Nothing Nothing
                , cell Nothing Nothing Nothing
                , cell Nothing Nothing Nothing
                , cell Nothing Nothing Nothing
                , cell Nothing Nothing Nothing
                ]


gridHtml : Model -> Html Msg
gridHtml model =
    div [ class "flex flex-colum p-5" ]
        [ div
            []
            [ homeBox [ True, True, True, True ] Blue
            , div [ class "col" ]
                [ lineHtml Blue "row" 0
                , lineHtml Blue "row" 1
                , lineHtml Blue "row" 4
                ]
            , homeBox [ True, True, True, True ] Red
            ]
        , div
            [ class "col" ]
            [ div [ class "flex" ]
                [ lineHtml Yellow "col" 4
                , lineHtml Yellow "col" 1
                , lineHtml Yellow "col" 0
                ]
            , div [ class "w-48 h-48" ] []
            , div [ class "flex" ]
                [ lineHtml Red "col" 2
                , lineHtml Red "col" 3
                , lineHtml Red "col" 4
                ]
            ]
        , div
            []
            [ homeBox [ True, True, True, True ]
                Yellow
            , div []
                [ lineHtml Green "row" 4
                , lineHtml Green "row" 3
                , lineHtml Green "row" 2
                ]
            , homeBox [ True, True, True, True ] Green
            ]
        ]


gameStartView model =
    div [ class " w-10 w-full  " ]
        []


view : Model -> Html Msg
view model =
    div [ class "flex h-screen justify-center items-center py-2" ]
        [ div [] [ Html.text model.messageToDisplay ]
        , case model.room of
            Just _ ->
                div []
                    [ div [ class "text-center text-white" ]
                        [ gridHtml model
                        , Html.text ("Room:  " ++ Maybe.withDefault "" model.room)
                        ]
                    ]

            Nothing ->
                div []
                    [ div [ class "text-center text-white" ]
                        [ gridHtml model
                        , Html.text ("Room:  " ++ Maybe.withDefault "" model.room)
                        ]
                    ]
        ]
