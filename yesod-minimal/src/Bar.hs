{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Bar where

import Blaze.ByteString.Builder.ByteString (copyByteString)
import Network.HTTP.Types (status200)
import Network.Wai (responseBuilder)
import Data.Aeson (encode)
import qualified Data.ByteString.Lazy as L
import Data.Text (Text)
import Foundation
import Yesod.Core

getBarR :: Handler ()
getBarR = sendWaiResponse
         $ responseBuilder
            status200
            [("Content-Type", simpleContentType typeJson)]
         $ copyByteString
         $ L.toStrict
         $ encode
         $ object ["message" .= ("Hello, World!" :: Text)]