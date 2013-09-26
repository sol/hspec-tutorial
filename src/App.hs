{-# LANGUAGE OverloadedStrings, DeriveDataTypeable #-}
module App where

import           Data.Data
import           Data.JSON (toJSON)
import           Data.Conduit
import           Blaze.ByteString.Builder.ByteString (fromByteString)
import           Data.Conduit.List (sourceList)
import           Web.Scotty hiding (json)
import           Network.Wai

data Message = Message {
  messageBody :: String
} deriving (Eq, Show, Data, Typeable)

json :: Data a => a -> ActionM ()
json data_ = do
  addHeader "Content-Type" "application/json"
  (source . sourceList . return . Chunk . fromByteString . toJSON) data_

app :: IO Application
app = scottyApp $ do
  get "/" $ do
    json (Message "Hello!")
