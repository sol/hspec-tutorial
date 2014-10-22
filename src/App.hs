{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}
module App where

import           Data.Aeson (ToJSON)
import           Web.Scotty
import           Network.Wai

import           GHC.Generics

data Message = Message {
  body :: String
} deriving (Eq, Show, Generic)

instance ToJSON Message

app :: IO Application
app = scottyApp $ do
  get "/" $ do
    json (Message "Hello!")
