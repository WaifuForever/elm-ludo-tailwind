module LudoModel exposing (PlayerColor(..), Model, Position(..), Msg(..))

type alias Model =
    { diceNum : Int
    , positions : List ( PlayerColor, Int )
    , turn : PlayerColor
    , maxPlayers : Maybe Int
    , room : Maybe String
    , roomToJoin : String
    , messageToDisplay : String
    , selectedPlayer : PlayerColor
    , participants : List PlayerColor
    }

type PlayerColor
    = Red
    | Green
    | Blue
    | Yellow

type Position
    = InCommonPathPosition Int CommonPathPosition
    | InStartBoxPosition Int
    | InHomePathPosition PlayerColor Int

type Msg
    = NewRandomNumber Int
    | MoveCoin Position
    | RollDice
    | MakeMove Position
    | RoomToBeJoinedChanged String
    | MaxPlayersChanged String
    | OnRoomJoinClicked
    | OnStartGameClicked
    | UpdateMessage String
    | UpdateRoom String Int Int

type CommonPathPosition
    = PathStar
    | PathStart PlayerColor
    | PathEnd PlayerColor
    | None