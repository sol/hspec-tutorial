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

spec :: Spec
spec = with app $ do
  describe "GET /" $ do
    it "responds with HTTP status 200" $ do
      get "/" `shouldRespondWith` 200

    it "says 'Hello!'" $ do
      get "/" `shouldRespondWith` [json|{body: "Hello!"}|]

  context "when given an invalid request path" $ do
    it "responds with HTTP status 404" $ do
      get "/some-path" `shouldRespondWith` 404
