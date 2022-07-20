module Update exposing (update)

import Delay
import Model exposing (Model, Msg(..), PlayerColour(..), Position(..))
import Platform.Cmd exposing (none)
import Random
import Rules exposing (canMove, moveAllTypes, nextTurn)
import Svg.Attributes exposing (seed)


shuffleList : Int -> List Int
shuffleList seed =
    case seed of
        0 ->
            [ 6, 5, 3, 4, 2, 1 ]

        1 ->
            [ 4, 2, 5, 6, 3, 1 ]

        2 ->
            [ 3, 4, 5, 2, 6, 1 ]

        3 ->
            [ 5, 6, 3, 4, 2, 1 ]

        4 ->
            [ 6, 2, 3, 4, 5, 1 ]

        5 ->
            [ 6, 4, 1, 3, 5, 2 ]

        6 ->
            [ 4, 6, 1, 5, 3, 2 ]

        7 ->
            [ 3, 5, 4, 1, 6, 2 ]

        8 ->
            [ 6, 3, 1, 4, 5, 2 ]

        9 ->
            [ 1, 6, 3, 4, 5, 2 ]

        10 ->
            [ 2, 4, 5, 6, 1, 3 ]

        11 ->
            [ 4, 6, 5, 1, 2, 3 ]

        12 ->
            [ 6, 1, 2, 5, 4, 3 ]

        13 ->
            [ 1, 5, 4, 6, 2, 3 ]

        14 ->
            [ 1, 2, 6, 4, 5, 3 ]

        15 ->
            [ 3, 5, 1, 6, 2, 4 ]

        16 ->
            [ 6, 3, 1, 5, 2, 4 ]

        17 ->
            [ 2, 3, 5, 1, 6, 4 ]

        18 ->
            [ 3, 2, 1, 5, 6, 4 ]

        19 ->
            [ 1, 2, 3, 6, 5, 4 ]

        20 ->
            [ 3, 1, 2, 6, 4, 5 ]

        21 ->
            [ 2, 1, 4, 3, 6, 5 ]

        22 ->
            [ 1, 3, 2, 4, 6, 5 ]

        23 ->
            [ 6, 2, 3, 4, 1, 5 ]

        24 ->
            [ 1, 2, 3, 4, 6, 5 ]

        25 ->
            [ 1, 4, 2, 5, 3, 6 ]

        26 ->
            [ 5, 4, 2, 3, 1, 6 ]

        27 ->
            [ 4, 2, 5, 1, 3, 6 ]

        28 ->
            [ 3, 5, 4, 1, 2, 6 ]

        _ ->
            [ 1, 2, 3, 4, 5, 6 ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DoNothing -> (model, Cmd.none)

        Roll ->
            ( { model | diceAnimation = True }
            , Random.generate RollAnimation (Random.int 0 29)
            )

        RollAnimation number ->
            update (NewFace (shuffleList number)) model

        NewFace list ->
            case list of
                [] ->
                    ( { model | diceAnimation = False }, Cmd.none )

                [ x ] ->
                    ( { model | diceNum = Just x }
                    , Delay.after 0
                        (NewFace [])
                    )

                ls ->
                    ( { model | diceNum = List.head ls }
                    , Delay.after 400
                        (NewFace
                            (case List.tail ls of
                                Just lsTail ->
                                    lsTail

                                Nothing ->
                                    []
                            )
                        )
                    )

        SetTurn number ->
            case number of
                6 ->
                    ( model, Cmd.none )

                _ ->
                    ( { model | participants = nextTurn model.participants }, Cmd.none )


nextTurn : List PlayerColour -> List PlayerColour
nextTurn list =
    let
        head =
            case List.head list of
                Just item ->
                    [ item ]

                Nothing ->
                    []
    in
    case List.tail list of
        Just tail ->
            List.concat [ tail, head ]

        Nothing ->
            list


getParticipantsByMaxPlayers : Int -> List PlayerColour
getParticipantsByMaxPlayers maxPlayers =
    case maxPlayers of
        2 ->
            [ Red, Yellow ]

        3 ->
            [ Red, Green, Yellow ]

        _ ->
            [ Red, Green, Yellow, Blue ]
