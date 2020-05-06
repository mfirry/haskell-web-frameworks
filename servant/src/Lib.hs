{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators   #-}
module Lib
    ( startApp
    , app
    ) where

import Data.Aeson
import Data.Aeson.TH
import Network.Wai
import Network.Wai.Handler.Warp
import Servant

data Message = Message
  { message :: String
  } deriving (Eq, Show)

$(deriveJSON defaultOptions ''Message)

type API = "plaintext" :> Get '[PlainText] String 
  :<|> "json" :> Get '[JSON] Message

startApp :: IO ()
startApp = run 3000 app

app :: Application
app = serve api server

api :: Proxy API
api = Proxy

server :: Server API
server = return notMuch 
  :<|> return _message

notMuch :: String
notMuch = "Hello, World!"     

_message :: Message
_message = Message "Hello, World!"