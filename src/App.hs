{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}
module App where

import           GHC.Generics
import           Data.Aeson (ToJSON)
import           Network.Wai (Application)
import           Web.Scotty
import           Data.Time
import           Control.Monad.IO.Class (liftIO)

data Service = Service {
  name    :: String
, version :: String
} deriving (Eq, Show, Generic)

instance ToJSON Service

data Response = Response {
  current_time :: String
} deriving (Eq, Show, Generic)

instance ToJSON Response

app :: IO UTCTime -> IO Application
app getTime = scottyApp $ do
  get "/" $ do
    json (Service "time-service" "0.1.0")

  get "/current-time.json" $ do
    t <- liftIO getTime
    json (Response $ show t)
