module Main where

import Prelude

import Effect (Effect)
import Halogen.Aff as HA
import Halogen.VDom.Driver (runUI)
import Halogen as H
import Halogen.HTML (ClassName(..))
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP

main :: Effect Unit
main = HA.runHalogenAff do
  body <- HA.awaitBody
  runUI component unit body

data Action = Nothing

component :: forall query input output m. H.Component query input output m
component =
    H.mkComponent
        { initialState
        , render
        , eval: H.mkEval H.defaultEval { handleAction = handleAction }
        }
    where
    initialState _ = "Hello World"

    render state =
        HH.h1 [ HP.class_ $ ClassName "red-color" ] [ HH.text state ]

    handleAction = case _ of
        Nothing -> H.modify_ \state -> state
