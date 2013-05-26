{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
module AppSpec (spec) where

import           Test.Hspec hiding (pending)
import           Test.Hspec.Wai
import           Test.Hspec.Wai.QuickCheck
import           Test.Hspec.Wai.JSON
import           Data.ByteString
import           Data.String

import           App (app)

data InvalidPath = InvalidPath ByteString
  deriving Show

instance Arbitrary InvalidPath where
  arbitrary = InvalidPath . fromString <$> (listOf1 . elements) ['A'..'z']
    `suchThat` (/= "a")

spec :: Spec
spec = with (app $ readIO "2013-04-11 21:37:58 UTC") $ do
  describe "GET /" $ do
    it "responds with HTTP status 200" $ do
      get "/" `shouldRespondWith` 200

    it "returns service name and version" $ do
      get "/" `shouldRespondWith` [json|{name: "time-service", version: "0.1.0"}|]

  describe "GET /current-time.json" $ do
    it "returns the current time" $ do
      get "/a" `shouldRespondWith` [json|{current_time: "2013-04-11 21:37:58 UTC"}|]

  context "when given an invalid request path" $ do
    it "responds with HTTP status 404" $ do
      get "/some-path" `shouldRespondWith` 404

  context "when given an *arbitrary* invalid request path" $ do
    it "responds with HTTP status 404" $ do
      property $ \(InvalidPath path) -> do
        get path `shouldRespondWith` 404
