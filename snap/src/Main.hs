{-# LANGUAGE OverloadedStrings #-}

module Main where

-- aeson
import Data.Aeson

-- snap
import Snap

-- text
import Data.Text

appInit :: SnapletInit () ()
appInit = makeSnaplet "myproj" "A simple application" Nothing $
  addRoutes [ ("plaintext", do
                              modifyResponse $ addHeader "Content-Type" "text/plain"
                              writeText "Hello, World!")
            , ("json"     , do
                              modifyResponse $ addHeader "Content-Type" "application/json"
                              writeLBS $ encode (object ["message" .= ("Hello, World!" :: Text)]))
            ]

main :: IO ()
main = serveSnaplet defaultConfig appInit
