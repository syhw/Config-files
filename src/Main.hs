{-# OPTIONS_GHC -Wall #-}

module Main (main) where

import Control.Monad
import Control.Monad.Trans
import Happstack.Server.SimpleHTTP
import System.Environment
import System.Exit
import System.Posix.IO
import System.Posix.Process
import Text.Atom.Feed
import Text.Atom.Feed.Export
import Text.XML.Light

import qualified Data.ByteString.Char8      as BS
import qualified Data.Map                   as M
import qualified Data.ByteString.Lazy.UTF8  as LU (fromString)


import ConfParser
import Types

-- FIXME GPL code (github/dpx-infinity/udisksevt)
doDaemonize :: IO () -> IO ()
doDaemonize prog = do
    _ <- forkProcess $ do
        _ <- createSession
        _ <- forkProcess $ do
            nullFd <- openFd "/dev/null" ReadWrite Nothing defaultFileFlags
            mapM_ closeFd [stdInput, stdOutput, stdError]
            mapM_ (dupTo nullFd) [stdInput, stdOutput, stdError]
            closeFd nullFd
            prog
        exitImmediately ExitSuccess
    putStrLn "Forked to background."
    exitImmediately ExitSuccess

main :: IO ()
main = do
  args <- getArgs
  let (fileName, daemon) = parseArgs args
  conf <- liftIO $ readConf fileName
  case conf of
    Left err -> putStrLn err
    Right c  -> do
                  putStrLn "Starting server"
                  if daemon
                    then doDaemonize (runServer c)
                    else runServer c

runServer :: ProxyConf -> IO ()
runServer =
  simpleHTTP nullConf . server

parseArgs :: [String] -> (FilePath, Bool)
parseArgs [x]      = (x, False)
parseArgs ["-d",x] = (x, True)
parseArgs _   = error "Usage : http-feedproxy conf.json"

newtype XML = XML Element

instance ToMessage XML where
  toContentType _   = BS.pack "application/xml"
  toMessage (XML e) = LU.fromString $ showElement e

server :: ProxyConf -> ServerPart XML
server conf = do
  hostBS <- fromMaybeM =<< getHeaderM "Host"
  let hostn = BS.unpack hostBS
  rq <- askRq
  rsp <- fromMaybeM (serveHost conf hostn (rqUri rq))
  return $ XML $ xmlFeed rsp

fromMaybeM :: MonadPlus m => Maybe a -> m a
fromMaybeM = maybe mzero return

serveHost :: ProxyConf -> Hostname -> Pathname -> Maybe Feed
serveHost (ProxyConf pConf) hostn qPath = do
  items <- M.lookup (hostn, qPath) pConf
  return (nullFeed hostn (TextString $ "TextContent for " ++ hostn) "now")
          { feedEntries = items }
