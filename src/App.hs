{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}
module App where

import           GHC.Generics
import           Data.Aeson (ToJSON)
import           Network.Wai
import           Web.Scotty

data Message = Message {
  body :: String
} deriving (Eq, Show, Generic)

instance ToJSON Message

app :: IO Application
app = scottyApp $ do
  get "/" $ do
    json (Message "Hello!")
