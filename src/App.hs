{-# LANGUAGE OverloadedStrings, DeriveDataTypeable #-}
module App where

import           Data.Data
import           Data.JSON (toJSON)
import qualified Data.ByteString.Lazy as LB
import           Web.Scotty hiding (json)
import           Network.Wai

data Message = Message {
  messageBody :: String
} deriving (Eq, Show, Data, Typeable)

json :: Data a => a -> ActionM ()
json data_ = do
  addHeader "Content-Type" "application/json"
  raw (LB.fromStrict $ toJSON data_)

app :: IO Application
app = scottyApp $ do
  get "/" $ do
    json (Message "Hello!")
