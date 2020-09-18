module Quill.Utils 
  ( optWith ) 
where

import Prelude
import Data.Op          (Op(Op))
import Data.Options     (Options(Options)
                        ,Option, opt)
import Data.Tuple       (Tuple(Tuple))
import Foreign          (Foreign, unsafeToForeign)

optWith :: forall opt a b . (a -> b) -> String -> Option opt a
optWith f = Op <<< \k v -> Options [ Tuple k (unsafeToForeign $ f v) ]
