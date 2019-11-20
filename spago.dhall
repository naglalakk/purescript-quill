{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name =
    "quill"
, dependencies =
    [ "colors"
    , "console"
    , "effect"
    , "foreign"
    , "foreign-generic"
    , "prelude"
    , "psci-support" 
    , "options"
    , "web-html"
    ]
, packages =
    ./packages.dhall
, sources =
    [ "src/**/*.purs", "test/**/*.purs" ]
}
