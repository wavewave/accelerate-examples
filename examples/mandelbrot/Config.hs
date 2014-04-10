{-# LANGUAGE CPP             #-}

module Config where

import ParseArgs
import Data.Label

data Options = Options
  {
    _optBackend         :: Backend
  , _optWidth           :: Int
  , _optHeight          :: Int
  , _optLimit           :: Int
  , _optFramerate       :: Int
  , _optBench           :: Bool
  , _optHelp            :: Bool
  }
  deriving Show

-- $(mkLabels [''Options])
optBackend = lens _optBackend (\f a -> a { _optBackend = f (_optBackend a) })

optWidth = lens _optWidth (\f a -> a { _optWidth = f (_optWidth a) })

optHeight = lens _optHeight (\f a -> a { _optHeight = f (_optHeight a) })

optLimit = lens _optLimit (\f a -> a { _optLimit = f (_optLimit a) })

optFramerate = lens _optFramerate (\f a -> a { _optFramerate = f (_optFramerate a) })

optBench = lens _optBench (\f a -> a { _optBench = f (_optBench a) })

optHelp = lens _optHelp (\f a -> a { _optHelp = f (_optHelp a) })



defaults :: Options
defaults = Options
  { _optBackend         = maxBound
  , _optWidth           = 800
  , _optHeight          = 600
  , _optLimit           = 255
  , _optFramerate       = 25
#ifdef ACCELERATE_ENABLE_GUI
  , _optBench           = False
#else
  , _optBench           = True
#endif
  , _optHelp            = False
  }

options :: [OptDescr (Options -> Options)]
options =
  [ Option []   ["width"]       (ReqArg ((\x f -> f {_optWidth=x}) . read) "INT")    "visualisation width (800)"
  , Option []   ["height"]      (ReqArg ((\x f -> f {_optHeight=x}) . read) "INT")   "visualisation height (600)"
  , Option []   ["limit"]       (ReqArg ((\x f -> f {_optLimit=x}) . read) "INT")    "iteration limit for escape (255)"
  , Option []   ["framerate"]   (ReqArg ((\x f -> f {_optFramerate=x}) . read) "INT")"visualisation framerate (10)"
  , Option []   ["static"]      (NoArg  (\f -> f {_optFramerate=0}))           "do not animate the image"
  , Option []   ["benchmark"]   (NoArg  (\f -> f {_optBench=True}))            "benchmark instead of displaying animation (False)"
  , Option "h?" ["help"]        (NoArg  (\f -> f {_optHelp=True}))             "show help message"
  ]


header :: [String]
header =
  [ "accelerate-mandelbrot (c) [2011..2013] The Accelerate Team"
  , ""
  , "Usage: accelerate-mandelbrot [OPTIONS]"
  , ""
  ]

footer :: [String]
footer =
  [ ""
  , "Runtime usage:"
  , "     arrows       translate display"
  , "     z ;          zoom in"
  , "     x q          zoom out"
  , "     f            single precision calculations"
  , "     d            double precision calculations (if supported)"
  ]

