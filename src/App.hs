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

app :: IO Application
app = scottyApp $ do
  get "/" $ do
    json (Service "time-service" "0.1.0")
