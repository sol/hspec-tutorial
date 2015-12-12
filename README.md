## Getting started

We will develop a small web service that provides access to the current time.

There is a skeleton project at https://github.com/sol/hspec-tutorial.  To setup
a local sandbox for development you can either use `stack` or `cabal`.  If you
are a beginner, use `stack`.

### Using `stack`

1. Install `stack`: http://docs.haskellstack.org/en/stable/README.html#how-to-install
2. Clone this repository:

   ```
   $ git clone https://github.com/sol/hspec-tutorial
   ```
3. Run the tests:

   ```
   $ cd hspec-tutorial
   $ stack test
   ```

Try the following things:

 * Run all specs with `stack test`.
 * Change a spec in `test/AppSpec.hs` so that it fails, rerun specs with `stack
   test`.
 * Start the service with

   ```
   $ stack ghci
   *Main> :main
   ```

   and point your web browser to <http://localhost:3000/>.

### Using `cabal`

```shell
$ git clone https://github.com/sol/hspec-tutorial
$ cd hspec-tutorial && cabal install --enable-tests --only-dependencies
```

Now you can build the project and run the tests with:

```shell
$ cabal configure --enable-test && cabal build && cabal test
```

But for development we prefer GHCi.  It is faster and provides nicer test
output.

Try the following things:

 * Start GHCi with `ghci test/Spec.hs` and run all specs with `:main`.
 * Run specs selectively with e.g. `:main -m "when given an invalid request path"`.
 * Change a spec in `test/AppSpec.hs` so that it fails, reload it with
   `:reload` and run it with `:main`.  Now you can rerun the failing spec with
   `:main -r`.
 * Start the service with `./dist/build/time-service/time-service` and point
   your web browser to <http://localhost:3000/>.

## Problem 1

`test/AppSpec.hs` contains some pending items.  Make them _green_.

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

## Problem 3

Make sure that the request path `/current-time.json` returns the current time,
e.g.

```json
{
  "current_time": "2013-04-11 21:37:58 UTC"
}
```

#### Hints

 * `ActionM` has a `MonadIO` instance, so you can use `liftIO` and
   `Data.Time.getCurrentTime` to get the current time.
 * But wait, don't use the real `getCurrentTime` in `app`, rather change its
   type to `IO UTCTime -> IO Application`, so that you can pass in a _mock_ for
   testing.

#### Bonus

 * Change the request path from `/current-time.json` to `/a` in both the specs
   and the app.  Now run the specs with `stack test --test-arguments="-a 100000"` or
   `:main -a 100000`.  Do they still pass?  If no, how can you remedy this?
