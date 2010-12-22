{-# OPTIONS_GHC -Wall #-}

module Types ( Hostname
             , Pathname
             , ProxyConf(..)
             ) where

import Text.Atom.Feed

import qualified Data.Map as M

type Hostname = String

type Pathname = String

newtype ProxyConf = ProxyConf (M.Map (Hostname, Pathname) [Entry])

