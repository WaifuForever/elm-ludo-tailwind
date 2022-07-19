module Model exposing (Model, Msg(..), PlayerColour(..), Position(..))


type alias Model =
    { diceNum : Int
    , positions : List ( List PlayerColour, Int )
    , turn : PlayerColour
    , maxPlayers : Maybe Int
    , room : Maybe String
    , roomToJoin : String
    , messageToDisplay : String
    , selectedPlayer : PlayerColour
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
    = RandomNumber
    | NewFace Int
    



type CommonPathPosition
    = PathStar
    | PathStart PlayerColour
    | PathEnd PlayerColour
    | None
