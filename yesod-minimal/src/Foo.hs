{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Foo where

import Blaze.ByteString.Builder.ByteString (copyByteString)
import Network.HTTP.Types (status200)
import Network.Wai (responseBuilder)
import Foundation
import Yesod.Core

getFooR :: Handler()
getFooR = sendWaiResponse
              $ responseBuilder
                status200
                [("Content-Type", simpleContentType typePlain)]
              $ copyByteString "Hello, World!"