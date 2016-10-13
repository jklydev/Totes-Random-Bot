module Main where

import Bot
import API
import Control.Concurrent (threadDelay)

main :: IO ()
main = tweetLoop

tweetLoop :: IO ()
tweetLoop = do
    bits <- getNewBits
    tweet bits
    float <- getNewFloat
    threadDelay $ ceiling ((read float :: Double) * 86400000000.0)
    tweetLoop
