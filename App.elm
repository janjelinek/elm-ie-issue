module Main exposing (main)

import Html exposing (Html, text)
import Html.Events
import Json.Encode exposing (Value)


type alias Model =
    { subModel : Maybe String }


type Msg
    = NoOp
    | ToggleOpen
    | SayHello
    | SubModelMsg SubMsg


type SubMsg
    = SetSubModel String


init : Value -> ( Model, Cmd Msg )
init flags_ =
    let
        _ =
            Debug.log "Program initialized with flags" flags_
    in
    ( Model Nothing, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ToggleOpen ->
            let
                newSubModel =
                    Maybe.map (always Nothing) model.subModel
                        |> Maybe.withDefault (Just "init")
            in
            ( { model | subModel = newSubModel }, Cmd.none )

        SayHello ->
            ( model, Cmd.none )

        SubModelMsg subMsg ->
            let
                ( newSubModel, subCmd ) =
                    updateSub subMsg model.subModel
            in
            ( { model | subModel = newSubModel }, Cmd.none )


updateSub msg model =
    case msg of
        SetSubModel s ->
            ( Just s, Cmd.none )


view model =
    Html.div [ Html.Events.onClick NoOp ]
        [ Html.button [ Html.Events.onClick ToggleOpen ] [ Html.text "Open" ]
        , Html.map SubModelMsg <| viewSub model.subModel
        ]


viewSub : Maybe String -> Html SubMsg
viewSub subModel =
    Maybe.map
        (\m ->
            Html.div []
                [ Html.button
                    [ Html.Events.onClick <| SetSubModel "Clicked, yeah."
                    ]
                    [ Html.text <| "Click here." ++ m ]
                ]
        )
        subModel
        |> Maybe.withDefault (Html.text "")


main : Program Value Model Msg
main =
    Html.programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
