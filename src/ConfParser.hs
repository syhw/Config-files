{-# LANGUAGE FlexibleContexts #-}
{-# OPTIONS_GHC -Wall #-}

module ConfParser (readConf) where

import Control.Monad.Error
import Text.Atom.Feed
import Text.JSON.String
import Text.JSON.Types

import qualified Data.Map as M

import Types

readConf :: (Functor m, MonadError String m) => FilePath -> IO (m ProxyConf)
readConf qPath = do
  fileContents <- readFile qPath
  let res = runGetJSON readJSArray fileContents
  case res of
    Right ja -> return $ parseConf ja
    Left e ->
      return $ throwError $ "Parse error : " ++ show e

parseConf :: (Functor m, MonadError String m) => JSValue -> m ProxyConf
parseConf js = do
  ja <- needArray js
  pps <- mapM parseProxyPart ja
  let pcl = map (\ pp -> ((ppHost pp, ppPath pp), ppItems pp)) pps
  return $ ProxyConf $ M.fromList pcl

data ProxyPart = ProxyPart { ppHost :: Hostname
                           , ppPath :: Pathname
                           , ppItems :: [Entry] 
                           }

needObject :: MonadError String m => JSValue -> m [(String, JSValue)]
needObject (JSObject (JSONObject jo)) = return jo
needObject _ = throwError "Object required"

needArray :: MonadError String m => JSValue -> m [JSValue]
needArray (JSArray ja) = return ja
needArray _  = throwError "Array required"

needString :: MonadError String m => JSValue -> m String
needString (JSString js) = return $ fromJSString js
needString _  = throwError "String required"

parseProxyPart :: MonadError String m => JSValue -> m ProxyPart
parseProxyPart j = do
  jo <- needObject j
  fHost  <- parseString =<< lookup' "host" jo
  fPath  <- parseString =<< lookup' "path" jo
  fItems <- parseItems  =<< lookup' "items" jo
  return ProxyPart { ppHost  = fHost
                   , ppPath  = fPath
                   , ppItems = fItems
                   }

parseString :: MonadError String m => JSValue -> m String
parseString = needString

parseItems :: MonadError String m => JSValue -> m [Entry]
parseItems jv = do
  ja <- needArray jv
  mapM parseItem ja

lookup' :: (Eq a, Show a, MonadError String m) => a -> [(a, b)] -> m b
lookup' k as =
  case lookup k as of
    Just x  -> return x
    Nothing -> throwError $ "Cannot find '" ++ show k ++ "'"

parseItem :: MonadError String m => JSValue -> m Entry
parseItem (JSObject (JSONObject svs)) =
  do
  	fId    <- parseString =<< lookup' "id"    svs
  	fTitle <- parseString =<< lookup' "title" svs
  	fLink  <- parseString =<< lookup' "link"  svs
  	return $ (nullEntry fId (TextString fTitle) "now") { entryLinks = [nullLink fLink] }
parseItem _ = throwError "id, title and link are required"
