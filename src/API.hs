module API where

import Network.HTTP

getNewBits :: IO String
getNewBits = simpleHTTP (getRequest "http://totes-random.website/bits") >>= getResponseBody

getNewFloat :: IO String
getNewFloat = simpleHTTP (getRequest "http://totes-random.website/float") >>= getResponseBody
