module Quill.API.Modules 
  ( Modules 
  , Toolbar
  , Handlers
  , syntax
  , toolbar
  , container
  , handlers
  , imgHandler
  )
  where

import Prelude
import Data.Op (Op(Op))
import Data.Options (Options(Options), Option, opt, options)
import Effect (Effect)
import Quill.Utils (optWith)

-- | https://quilljs.com/docs/modules/
data Modules
data Handlers
data Toolbar 
data History

toolbar :: Option Modules (Options Toolbar)
toolbar = optWith options "toolbar"

container :: Option Toolbar (Array (Array String))
container = opt "container"

syntax :: Option Modules Boolean
syntax = opt "syntax"

handlers :: Option Toolbar (Options Handlers)
handlers = optWith options "handlers"

imgHandler :: Option Handlers (Effect Unit)
imgHandler = opt "image"
