{ name = "graphql-milkis"
, dependencies =
    [ "console"
    , "prelude"
    , "either"
    , "newtype"
    , "foreign-object"
    , "effect"
    , "aff"
    , "graphql-generic"
    , "milkis"
    , "simple-json"
    , "psci-support"
    ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
