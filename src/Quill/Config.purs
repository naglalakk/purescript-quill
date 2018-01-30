module Quill.Config
    ( Config
    , Theme(..)
    , Allowed
    , module Debug
    , bounds
    , debug
    , formats
    , allow
    , placeholder
    , readOnly
    , strict
    , theme
    ) where

import Prelude

import Data.Foldable (foldMap)
import Data.Foreign (toForeign)
import Data.Newtype (unwrap)
import Data.Op (Op(..))
import Data.Options (Options(..), Option, (:=), opt, tag)
import Data.Tuple (Tuple(..), fst)

import DOM.HTML.Types (HTMLElement)

import Quill.API.Debug (Debug)
import Quill.API.Debug as Debug
import Quill.API.Formats (Formats)

import Unsafe.Coerce (unsafeCoerce)

-- | https://quilljs.com/docs/configuration/
data Config

-- | https://quilljs.com/docs/configuration/#bounds
bounds :: Option Config HTMLElement
bounds = opt "bounds"

-- | https://quilljs.com/docs/api/#debug
debug :: Option Config Debug
debug = opt "bounds"

-- | https://quilljs.com/docs/configuration/#formats
formats :: Option Config (Array Allowed )
formats = optWith formatKeys "formats"
    where
        formatKeys :: Array Allowed -> Array String
        formatKeys = (foldMap \(Allowed o) -> o := unit)
                 >>> (unwrap >>> map fst)

-- | Specifies a whitelisted format option.
newtype Allowed = Allowed (Option Formats Unit)

-- | Whitelist a format option.
allow :: forall a. Option Formats a -> Allowed
allow o = Allowed (tag o (unsafeCoerce unit))

-- | https://quilljs.com/docs/configuration/#placeholder
placeholder :: Option Config String
placeholder = opt "placeholder"

-- | https://quilljs.com/docs/configuration/#readonly
readOnly :: Option Config Boolean
readOnly = opt "readOnly"

-- | https://quilljs.com/docs/configuration/#strict
strict :: Option Config Boolean
strict = opt "readOnly"

-- | https://quilljs.com/docs/configuration/#theme
theme :: Option Config Theme
theme = optWith show "theme"

-- | https://quilljs.com/docs/themes/
data Theme
    = BubbleTheme  -- 'bubble' (builtin)
    | SnowTheme    -- 'snow'   (builtin)
    | CustomTheme String

instance showTheme :: Show Theme where
    show BubbleTheme = "bubble"
    show SnowTheme   = "snow"
    show (CustomTheme name) = name

optWith :: forall opt a b . (a -> b) -> String -> Option opt a
optWith f = Op <<< \k v -> Options [Tuple k (toForeign $ f v)]
