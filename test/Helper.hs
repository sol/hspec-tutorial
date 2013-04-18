{-# LANGUAGE OverloadedStrings #-}
module Helper where

import           Test.Hspec
import           Test.HUnit (assertBool)
import           Network.Wai.Test
import           Network.Wai (Application)

import           Control.Applicative
import           Data.List (isInfixOf)
import           Data.ByteString (ByteString)
import qualified Data.ByteString.Lazy.Char8 as L
import qualified Network.HTTP.Types as HTTP

getPath :: ByteString -> Application -> IO SResponse
getPath p = (runSession . srequest) (SRequest req "")
  where
    req = setPath defaultRequest p

body :: SResponse -> L.ByteString
body res = simpleBody res

statusCode :: SResponse -> Int
statusCode = HTTP.statusCode . simpleStatus

shouldRespondWith :: IO SResponse -> Int -> Expectation
action `shouldRespondWith` status = do
  (statusCode <$> action) `shouldReturn` status

shouldContain :: L.ByteString -> L.ByteString -> Expectation
haystack `shouldContain` needle = assertBool err (n `isInfixOf` h)
  where
    h = L.unpack haystack
    n = L.unpack needle
    err = concat [
      "Expectation failed on ", show h, ", it did not contain ", show n, "!"]
