module Model exposing (Model, Msg(..), PlayerColour(..), Position(..))


type alias Model =
    { diceNum : Maybe Int
    , diceAnimation : Bool
    , positions : List ( List PlayerColour, Int )
    , maxPlayers : Maybe Int
    , room : Maybe String
    , roomToJoin : String
    , messageToDisplay : String
    , participants : List PlayerColour
    }

type PlayerColour
    = Red
    | Green
    | Blue
    | Yellow


type Position
    = InCommonPathPosition Int CommonPathPosition
    | InStartBoxPosition Int
    | InHomePathPosition PlayerColour Int


type Msg
    = Roll
    | NewFace (List Int)
    | RollAnimation Int
    | SetTurn Int
    | DoNothing
    



type CommonPathPosition
    = PathStar
    | PathStart PlayerColour
    | PathEnd PlayerColour
    | None
