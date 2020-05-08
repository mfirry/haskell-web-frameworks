{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

-- base
import GHC.Generics

-- aeson
import Data.Aeson       hiding (json)

import Web.Spock
import Web.Spock.Config

main :: IO ()
main = do
  spockCfg <- defaultSpockCfg () PCNoDatabase ()
  runSpock 3000 (spock spockCfg app)

newtype Response = Response {message :: String}
  deriving (Show, Generic)

instance ToJSON Response

app :: SpockM () () () ()
app = do
  get "plaintext" $
    text "Hello World!"
  get "json" $
    json $ Response "Hello world!"
