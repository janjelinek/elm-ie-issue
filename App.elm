module Main exposing (main)

import Html exposing (Html, text)
import Html.Events


type alias Model =
    { subModel : Maybe String }


type Msg
    = ToggleOpen
    | SayHello
    | SubModelMsg SubMsg


type SubMsg
    = SetSubModel String


init =
    ( Model Nothing, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleOpen ->
            let
                newSubModel =
                    Maybe.map (always Nothing) model.subModel
                        |> Maybe.withDefault (Just "ASDF")
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
    Html.div []
        [ Html.button [ Html.Events.onClick ToggleOpen ] [ Html.text "Open" ]
        , Html.map SubModelMsg <| viewSub model.subModel
        ]


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


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
