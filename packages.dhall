let upstream =
      https://github.com/purescript/package-sets/releases/download/psc-0.14.1-20210427/packages.dhall sha256:edbb8f70232fb83895c7ce02f5d2b29f6ee1722f1a70fc58d3bc0ab0de18afe4

in  upstream
  with graphql-generic =
    { dependencies =
        [ "effect"
        , "prelude"
        , "record"
        ]
    , repo = "https://github.com/jac3km4/purescript-graphql-generic.git"
    , version = "ca1877e2f6b85bfc0d9e0c2b995a4e8392d67123"
    }
