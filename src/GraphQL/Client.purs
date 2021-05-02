module GraphQL.Client (runQuery, Id(..)) where

import Data.Either (either)
import Data.Newtype (class Newtype)
import Effect.Aff (Aff, error, throwError)
import Foreign.Object as Object
import GraphQL (class QueryRecord)
import GraphQL as GQL
import Milkis as M
import Milkis.Impl.Window (windowFetch)
import Prelude (bind, map, pure, show, ($), (<<<))
import Prim.RowList as RL
import Simple.JSON (class ReadForeign)
import Simple.JSON as JSON

fetch :: M.Fetch
fetch = M.fetch windowFetch

runQuery ::
  ∀ row rl out.
  RL.RowToList row rl =>
  QueryRecord rl row out =>
  ReadForeign (Record out) =>
  M.URL ->
  M.Headers ->
  Record row ->
  Aff { data :: Record out }
runQuery url headers q = do
  res <- fetch url { method: M.postMethod, body: JSON.writeJSON { query }, headers: headers' }
  body <- M.json res
  either (throwError <<< error <<< show) pure $ JSON.read body
  where
  headers' = Object.insert "Content-Type" "application/json" headers

  query = GQL.render q

newtype Id a
  = Id a

derive instance newtypeId :: Newtype (Id a) _

instance readId :: ReadForeign a => ReadForeign (Id a) where
  readImpl = map Id <<< JSON.readImpl
