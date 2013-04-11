module Main (main) where

import           App
import           Network.Wai.Handler.Warp
import           Data.Time

main :: IO ()
main = do
  putStrLn "http://localhost:3000"
  app getCurrentTime >>= run 3000
