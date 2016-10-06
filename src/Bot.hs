{-# LANGUAGE OverloadedStrings #-}

module Bot where

import           Data.ByteString
import           Data.Monoid
import           System.Environment
import qualified Data.ByteString.Char8 as B8
import qualified Data.ByteString.Lazy  as BL
import qualified Network.HTTP.Base     as HTTP
import           Network.HTTP.Client
import           Network.HTTP.Client.TLS
import           Network.HTTP.Types
import           Web.Authenticate.OAuth

getEnv' = (B8.pack <$>) . getEnv

oauthTwitter :: IO OAuth
oauthTwitter = do
  apiKey <- getEnv' "OAUTH_ACCESS_TOKEN"
  apiSecret <- getEnv' "OAUTH_ACCESS_SECRET"
  let oauth = newOAuth { oauthServerName      = "twitter"
           , oauthRequestUri      = "https://api.twitter.com/oauth/request_token"
           , oauthAccessTokenUri  = "https://api.twitter.com/oauth/access_token"
           , oauthAuthorizeUri    = "https://api.twitter.com/oauth/authorize"
           , oauthSignatureMethod = HMACSHA1
           , oauthConsumerKey     = apiKey
           , oauthConsumerSecret  = apiSecret
           , oauthVersion         = OAuth10a
           }
  return oauth

signAuth :: Request -> IO Request
signAuth request = do
  userKey <- getEnv' "OAUTH_CONSUMER_KEY"
  userSecret <- getEnv' "OAUTH_CONSUMER_SECRET"
  oauthTwitter' <- oauthTwitter
  signOAuth oauthTwitter' (newCredential userKey userSecret) request

tweet :: String -> IO (Response BL.ByteString)
tweet status = do
  url <- parseUrl $ "https://api.twitter.com/1.1/statuses/update.json?status=" `Data.Monoid.mappend` (HTTP.urlEncode status)
  print url
  req <- signAuth url{ method = "POST" }
  manager <- newManager tlsManagerSettings
  httpLbs req manager
