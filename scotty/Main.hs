-- aeson
import Data.Aeson (object, (.=))

-- scotty
import Web.Scotty

-- text
import Data.Text (Text)

main :: IO ()
main = scotty 3000 $ do
  get "/plaintext" $ text "Hello, World!"

  get "/json" $ json (object ["message" .= ("Hello, World!" :: Text)])
