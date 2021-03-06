module Types exposing
    ( Board
    , CellType(..)
    , CpuFireEngine
    , Direction(..)
    , FloatCoord
    , Grid
    , GridCoord
    , GridSize
    , Model
    , Msg(..)
    , Rect
    , Ship
    , ShipDef
    , State(..)
    , Turn(..)
    )

import Animator
import Animator.Inline
import Dict exposing (Dict)
import Html.Events.Extra.Mouse as Mouse
import Matrix exposing (Matrix)
import Time


type Turn
    = Player
    | CPU


type State
    = Preparing
    | Playing Turn
    | End Turn


type alias Board =
    { matrix : Matrix CellType
    , shipsToPlace : List ShipDef
    , ships : Dict String Ship
    , shots : Matrix Bool
    , cellUnderMouse : Maybe GridCoord
    , grid : Grid
    , id : String
    }


type alias CpuFireEngine =
    { lastSuccesses : List GridCoord
    }


type alias Model =
    { myBoard : Board
    , cpuBoard : Board
    , currentMousePos : FloatCoord
    , clickedShip : Maybe Ship
    , clickedCell : Maybe GridCoord
    , clickedPos : FloatCoord
    , focusedShip : Maybe Ship
    , firing : Animator.Timeline Bool
    , firingCell : Maybe GridCoord
    , draggingShip : Bool
    , state : State
    , cpuFireEngine : CpuFireEngine
    }


type Msg
    = GetCoordAndDirection Turn ( GridCoord, Direction )
    | Generate Turn
    | PieceOver String
    | PieceOut String
    | Launch
    | MouseMove String Mouse.Event
    | MouseDown String Mouse.Event
    | MouseUp String Mouse.Event
    | SvgMousePosResult ( String, Float, Float )
    | GetCellCandidate GridCoord
    | Tick Time.Posix
    | PlayCPU
    | NewGame


type alias ShipDef =
    { id : String
    , size : Int
    }


type alias Ship =
    { pos : GridCoord
    , size : Int
    , dir : Direction
    , id : String
    }


type CellType
    = Occupied
    | NextTo
    | Free


type Direction
    = North
    | East
    | South
    | West


type alias GridCoord =
    { col : Int
    , row : Int
    }


type alias GridSize =
    { width : Int
    , height : Int
    }


type alias FloatCoord =
    { x : Float
    , y : Float
    }


type alias Rect =
    { topLeft : GridCoord
    , bottomRight : GridCoord
    }


type alias Grid =
    { colCount : Int
    , rowCount : Int
    , boldInterval : Int
    , thinThickness : Float
    , boldThickness : Float
    , cellSize : Float
    , topLeft : FloatCoord
    , strokeColor : String
    }
