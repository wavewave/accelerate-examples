module Config where

import ParseArgs
import Data.Label

data Config
  = Config
  {
    -- Standard options
    _configBackend              :: Backend
  , _configHelp                 :: Bool
  }


configBackend = lens _configBackend (\f a -> a { _configBackend = f (_configBackend a) })

configHelp = lens _configHelp (\f a -> a { _configHelp = f (_configHelp a) })


defaults :: Config
defaults = Config
  {
    _configBackend              = maxBound
  , _configHelp                 = False
  }

options :: [OptDescr (Config -> Config)]
options =
  [ Option  ['h', '?'] ["help"]
            (NoArg (set configHelp True))
            "show this help message"
  ]
  where
    _describe f msg
      = msg ++ " (" ++ show (get f defaults) ++ ")"


header :: [String]
header =
  [ "accelerate-smvm (c) [2013] The Accelerate Team"
  , ""
  , "Usage: accelerate-smvm [OPTIONS] matrix.mtx"
  , ""
  ]

footer :: [String]
footer = []


