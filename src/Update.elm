module Update exposing (update)

import Model exposing (Model, Msg(..), PlayerColour(..), Position(..))
import Random
import Rules exposing (canMove, moveAllTypes, nextTurn)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RandomNumber ->
            ( model
            , Random.generate NewFace (Random.int 1 6)
            )

        NewFace newFace ->
                ( { model | diceNum = newFace }
                , Cmd.none
                )


getParticipantsByMaxPlayers : Int -> List PlayerColour
getParticipantsByMaxPlayers maxPlayers =
    case maxPlayers of
        2 ->
            [ Red, Yellow ]

        3 ->
            [ Red, Green, Yellow ]

        _ ->
            [ Red, Green, Yellow, Blue ]
