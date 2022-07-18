module Main exposing (main)

import Array exposing (Array)
import Browser
import Cell exposing (sharedCell)
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
      , positions = [ ]
      , maxPlayers = Just 2
      , room = Nothing
      , roomToJoin = ""
      , messageToDisplay = ""
      , selectedPlayer = Red
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
    div [ class "flex border-2 border-white bg-white rounded-xl" ]
        [ div
            []
            [ homeBox (sparePieces model.positions Blue) Blue "rounded-tl-xl"
            , div [ class "col" ]
                [ lineHtml model Blue "row" 0 (List.reverse (List.range 0 5))
                , lineHtml model Blue "row" 1 (List.range 6 11)
                , lineHtml model Blue "row" 4 (List.range 12 17)
                ]
            , homeBox (sparePieces model.positions Red) Red "rounded-bl-xl"
            ]
        , div
            [ class "col" ]
            [ div [ class "flex" ]
                [ lineHtml model Yellow "col" 4 (List.range 66 71) 
                , lineHtml model Yellow "col" 1 (List.range 60 65)
                , lineHtml model Yellow "col" 0 (List.reverse (List.range 54 59) )
                ]
            , div [ class "w-48 h-48" ] []
            , div [ class "flex" ]
                [ lineHtml model Red "col" 2 (List.range 18 23) 
                , lineHtml model Red "col" 3 (List.reverse (List.range 24 29))
                , lineHtml model Red "col" 4 (List.reverse (List.range 30 35))
                ]
            ]
        , div
            []
            [ homeBox (sparePieces model.positions Yellow) Yellow "rounded-tr-xl"
            , div []
                [ lineHtml model Green "row" 4 (List.reverse (List.range 48 53))
                , lineHtml model Green "row" 3 (List.reverse (List.range 42 47)) 
                , lineHtml model Green "row" 2 (List.range 36 41 ) 
                ]
            , homeBox (sparePieces model.positions Green) Green "rounded-br-xl"
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
                    [ div [ class "text-center text-black" ]
                        [ gridHtml model
                        , Html.text ("Room:  " ++ Maybe.withDefault "" model.room)
                        ]
                    ]

            Nothing ->
                div []
                    [ div [ class "text-center text-black" ]
                        [ gridHtml model
                        , Html.text ("Room:  " ++ Maybe.withDefault "" model.room)
                        ]
                    ]
        ]
