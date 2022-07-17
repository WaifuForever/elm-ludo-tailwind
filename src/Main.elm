module Main exposing (main)

import Browser
import Cell exposing (cell)
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


gridHtml : Model -> Html Msg
gridHtml model =
    div
        [ class "p-5"
        ]
        [ homeBox [ True, True, True, True ] Red
        , div [ class "flex border" ]
            [ cell Nothing "gray"
            , cell Nothing "gray"
            , cell Nothing "gray"
            , cell Nothing "gray"
            , cell Nothing "gray"
            , cell Nothing "gray"
            ]
        ]


gameStartView model =
    div [ class " w-10 w-full  " ]
        []


view : Model -> Html Msg
view model =
    div []
        [ div [] [ Html.text model.messageToDisplay ]
        , case model.room of
            Just _ ->
                div []
                    [ div [ class "my-8  text-center text-white" ]
                        [ gridHtml model
                        , Html.text ("Room:  " ++ Maybe.withDefault "" model.room)
                        ]
                    ]

            Nothing ->
                div []
                    [ div [ class "my-8  text-center text-white" ]
                        [ gridHtml model
                        , Html.text ("Room:  " ++ Maybe.withDefault "" model.room)
                        ]
                    ]
        ]
