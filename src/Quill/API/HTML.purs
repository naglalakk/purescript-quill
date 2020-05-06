module Quill.API.HTML 
  ( getHTMLString )
where

import Prelude
import Control.Monad.Error.Class    (class MonadError
                                    ,throwError)
import Control.Monad.Except         (runExcept)
import Data.Either                  (either)
import Effect.Class                 (class MonadEffect
                                    ,liftEffect)
import Effect.Uncurried             as UncurriedEffect
import Foreign                      as Foreign
import Quill.Editor                 (Editor)

foreign import getHTMLStringImpl :: UncurriedEffect.EffectFn1 Editor Foreign.Foreign

getHTMLString :: forall m
               . MonadEffect m 
              => MonadError Foreign.MultipleErrors m
              => Editor 
              -> m String
getHTMLString editor = either throwError pure <<< runExcept <<< Foreign.readString <=< liftEffect $ UncurriedEffect.runEffectFn1 getHTMLStringImpl editor
