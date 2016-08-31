{-# LANGUAGE OverloadedStrings #-}

module Bot where

import qualified Data.ByteString.Lazy as BL
import qualified Network.HTTP.Base as HTTP
import Network.HTTP.Client
import Network.HTTP.Client.TLS
import Network.HTTP.Types
import Web.Authenticate.OAuth

import Info


oauthTwitter :: OAuth
oauthTwitter =
  newOAuth { oauthServerName      = "twitter"
           , oauthRequestUri      = "https://api.twitter.com/oauth/request_token"
           , oauthAccessTokenUri  = "https://api.twitter.com/oauth/access_token"
           , oauthAuthorizeUri    = "https://api.twitter.com/oauth/authorize"
           , oauthSignatureMethod = HMACSHA1
           , oauthConsumerKey     = apiKey
           , oauthConsumerSecret  = apiSecret
           , oauthVersion         = OAuth10a
           }

signAuth :: Request -> IO Request
signAuth = signOAuth oauthTwitter $ newCredential userKey userSecret

tweet :: String -> IO (Response BL.ByteString)
tweet status = do
  url <- parseUrl $ "https://api.twitter.com/1.1/statuses/update.json?status=" ++ HTTP.urlEncode status
  req <- signAuth url{ method = "POST" }
  manager <- newManager tlsManagerSettings
  httpLbs req manager
