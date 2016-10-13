module API where

import Network.HTTP
import Data.List (isInfixOf)
import Control.Concurrent (threadDelay)


getNewBits :: IO String
getNewBits = do
    let iobits = simpleHTTP (getRequest "http://totes-random.website/bits") >>= getResponseBody
    bits <- iobits
    if ("error" `isInfixOf` bits)
        then do
            threadDelay 300
            getNewBits
        else iobits



getNewFloat :: IO String
getNewFloat = do
    let iofloat = simpleHTTP (getRequest "http://totes-random.website/float") >>= getResponseBody
    float <- iofloat
    if ("error" `isInfixOf` float)
        then do
            threadDelay 300
            getNewFloat
        else iofloat
