module Quill.API.Formats
    ( Formats
    , SingleFormat
    , Alignment(Left, Center, Right, Justify)
    , FontName
    , singleFormat
    , name
    , value
    , background
    , color
    , bold
    , font
    , code
    , italic
    , link
    , size
    , strike
    , underline
    , blockquote
    , header
    , indent
    , align
    , codeBlock
    , video
    , image
    )
where

import Prelude

import Color (Color, toHexString)
import Data.Array (head)
import Data.Maybe (fromJust)
import Data.Newtype (unwrap)
import Data.Op (Op(Op))
import Data.Options (Options(Options), Option, opt, assoc)
import Data.Tuple (Tuple(Tuple))
import Foreign (Foreign, unsafeToForeign)
import Partial.Unsafe (unsafePartial)
import Quill.API.Embed as QEmbed
import Quill.Utils (optWith)


-- | https://quilljs.com/docs/formats/
data Formats


background :: Option Formats Color
background = optWith toHexString "background"


color :: Option Formats Color
color = optWith toHexString "color"


bold :: Option Formats Boolean
bold = opt "bold"


font :: Option Formats FontName
font = opt "font"


code :: Option Formats Boolean
code = opt "code"


italic :: Option Formats Boolean
italic = opt "italic"


link :: Option Formats Boolean
link = opt "link"

size :: Option Formats Number
size = opt "size"


strike :: Option Formats Boolean
strike = opt "strike"


underline :: Option Formats Boolean
underline = opt "underline"


blockquote :: Option Formats Boolean
blockquote = opt "blockquote"


header :: Option Formats Int
header = opt "header"


indent :: Option Formats Int
indent = opt "indent"


align :: Option Formats Alignment
align = optWith show "align"


codeBlock :: Option Formats Boolean
codeBlock = opt "code-block"

video :: Option Formats QEmbed.Embed
video = opt "video"

image :: Option Formats QEmbed.Embed
image = opt "image"

-- | Text alignment.
data Alignment
    = Left
    | Center
    | Right
    | Justify

instance showAlignment :: Show Alignment where
    show Left   = "left"
    show Center = "center"
    show Right  = "right"
    show _      = "justify" -- HACK: see `optWith` comment below


newtype SingleFormat = SingleFormat (Tuple String Foreign)


singleFormat :: forall a. Option Formats a -> a -> SingleFormat
singleFormat o v = SingleFormat $ unsafePartial $ fromJust $ head $ unwrap $ assoc o v


name :: SingleFormat -> String
name (SingleFormat (Tuple n _)) = n


value :: SingleFormat -> Foreign
value (SingleFormat (Tuple _ v)) = v


-- | E.g. "sans-serif"
type FontName = String
