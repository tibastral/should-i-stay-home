-- A text input for reversing text. Very useful!
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/text_fields.html
--


module Main exposing (Model, Msg(..), init, main, update, view)

import BodyBuilder as B exposing (NodeWithStyle)
import BodyBuilder.Attributes as A
import BodyBuilder.Events as E
import BodyBuilder.Extra as Layout
import BodyBuilder.Style as Style
import Browser
import Elegant exposing (percent, px)
import Elegant.Background as Background
import Elegant.Block as Block
import Elegant.Border as Border
import Elegant.Box as Box
import Elegant.Constants as Constants
import Elegant.Corner as Corner
import Elegant.Dimensions as Dimensions
import Elegant.Display as Display
import Elegant.Extra
    exposing
        ( alignCenter
        , block
        , blockProperties
        , blockWithWidth
        , bold
        , border
        , box
        , cursorPointer
        , displayBlock
        , fontSize
        , grow
        , padding
        , paddingAll
        , paddingBottom
        , paddingHorizontal
        , paddingTop
        , paddingVertical
        , typoSize
        , typography
        )
import Elegant.Flex as Flex
import Elegant.Grid as Grid
import Elegant.Margin as Margin
import Elegant.Overflow as Overflow
import Elegant.Padding as Padding
import Elegant.Position as Position
import Elegant.Shadow as Shadow
import Elegant.Transform as Transform
import Elegant.Typography as Typography



-- import Html exposing (Attribute, Html, div, input, text)
-- import Html.Attributes exposing (..)
-- import Html.Events exposing (onInput)
-- MAIN


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = B.stylise view
        }



-- MODEL


type alias Model =
    { contaminedPersonsByOnePerson : Int
    , confined : Bool
    }



-- (Trouver un modèle de contamination. En gros : par heure dehors, combien de personnes on peut contaminer. L ecrire.)
-- nombre de perso
-- Nombre de contaminations dont on est le vecteur
-- Nombre de morts dont on est le vecteur
-- Par jour


init : Model
init =
    { contaminedPersonsByOnePerson = 2
    , confined = True
    }



-- UPDATE


type Msg
    = Change String



-- porcentage de morts liés à COVID
-- nombre de personnes contaminées par une personne


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            { model | contaminedPersonsByOnePerson = String.toInt newContent |> Maybe.withDefault 0 }



-- VIEW


casualties nb =
    nb * 100


view : Model -> B.NodeWithStyle Msg
view model =
    B.div []
        [ B.inputText [ A.placeholder "Text to reverse", A.value (model.contaminedPersonsByOnePerson |> String.fromInt), E.onInput Change ]
        , B.div [] [ B.text (casualties model.contaminedPersonsByOnePerson |> String.fromInt) ]
        ]
