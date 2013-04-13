## Getting started

We will develop a small web service that provides access to the current time.

There is a skeleton project at https://github.com/sol/hspec-tutorial.  To setup
a local sandbox for development run:

```shell
$ git clone https://github.com/sol/hspec-tutorial
$ cd hspec-tutorial && cabal install --enable-tests --only-dependencies
```

Now you can build and run the project with:

```shell
$ cabal configure --enable-test && cabal build && cabal test
```

But for development we prefer GHCi.  It is faster and provides nicer test
output.

Try the following things:

 * Start GHCi with `ghci test/Spec.hs` and run all specs with `:main`.
 * Run specs selectively with `:main -m "when given an invalid request path"`.
 * Change a spec in `test/AppSpec.hs` so that it fails, reload it with
   `:reload` and run it with `:main`.  Now you can rerun only the failing spec
   with `:main -r`.
 * Start the service with `./dist/build/time-service/time-service` and point
   your web browser to http://localhost:3000/.

## Problem 1

 * In `test/AppSpec.hs` we use `shouldReturn` to test for the expected HTTP status
code.  Refactor this to use the more specific `shouldRespondWith` (defined in
`test/Helper.hs`).
 * `test/AppSpec.hs` contains some pending items.  Make them _green_.


#### Solution

 * https://github.com/sol/hspec-tutorial/blob/solution1/test/AppSpec.hs (specs)

## Problem 2

Change the application so that a request to `/` returns JSON that is equivalent
to:

```json
{
  "name":    "time-service",
  "version": "0.1.0"
}
```

#### Hints

 * First adapt the specs in `test/AppSpec.hs`, run the specs and see them fail,
   work on `src/App.hs` until your specs are green again.
 * Use two expectations with `shouldContain` (defined in `test/AppSpec.hs`) to
   test for `name` and `version` separately.
 * Have a look at https://github.com/sol/json-fu#readme to understand how
   algebraic data types are mapped to JSON.

#### Solution

 * https://github.com/sol/hspec-tutorial/blob/solution2/src/App.hs (specs)
 * https://github.com/sol/hspec-tutorial/blob/solution2/test/AppSpec.hs (code)

## Problem 3

Make sure that the request path `/current-time.json` returns the current time,
e.g.

```json
{
  "current_time": "2013-04-11 21:37:58.600987 UTC"
}
```

#### Hints

 * When you define the route in `src/App.hs` you have to start it with a `/`
   (say use `/current-time.json`), but in the specs you must omit it (say use
   `current-time.json`)!
 * `ActionM` has a `MonadIO` instance, so you can use `liftIO` to run
   `Data.Time.getCurrentTime` to get the current time.
 * But wait, don't use the real `getCurrentTime` in `app`, rather change its
   type to `IO UTCTime -> IO Application`, so that you can pass in a _mock_ for
   testing.

#### Bonus

 * Change the request path from `current-time.json` to `a` in both the specs
   and the app.  Now run the specs with `:main -a 1000`.  Do they still pass?
   If no, how can you remedy this?

#### Solution

 * https://github.com/sol/hspec-tutorial/blob/solution3/src/App.hs (specs)
 * https://github.com/sol/hspec-tutorial/blob/solution3/test/AppSpec.hs (code)
