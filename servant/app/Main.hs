{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TypeOperators   #-}

module Main where
  
-- base
import GHC.Generics

-- aeson
import Data.Aeson       (ToJSON)

import Network.Wai
import Network.Wai.Handler.Warp
import Servant

main :: IO ()
main = startApp

newtype Message = Message {message :: String}
  deriving (Show, Generic)

instance ToJSON Message

type API = "plaintext" :> Get '[PlainText] String
  :<|> "json" :> Get '[JSON] Message

startApp :: IO ()
startApp = run 3000 app

app :: Application
app = serve api server

api :: Proxy API
api = Proxy

server :: Server API
server = return plainText
  :<|> return json

plainText :: String
plainText = "Hello, World!"

json :: Message
json = Message "Hello, World!"