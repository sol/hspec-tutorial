{-# LANGUAGE OverloadedStrings #-}
module AppSpec (main, spec) where

import           Test.Hspec
import           Test.QuickCheck
import           Network.Wai.Test (SResponse)
import           Data.ByteString (ByteString)
import           Control.Applicative

import           Helper
import           App

main :: IO ()
main = hspec spec

get :: ByteString -> IO SResponse
get path = app >>= getPath path

spec :: Spec
spec = do
  describe "GET /" $ do
    it "responds with HTTP status 200" $ do
      (statusCode <$> get "/") `shouldReturn` 200

    it "says 'Hello!'" $ do
      (body <$> get "/") `shouldReturn` "{\"body\":\"Hello!\"}"

  context "when given an invalid request path" $ do
    it "responds with HTTP status 404" $ do
      pending

  context "when given an *arbitrary* invalid request path" $ do
    it "responds with HTTP status 404" $ do
      property $
        pending
