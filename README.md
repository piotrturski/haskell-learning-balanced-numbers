# Learning haskell: Balanced Numbers

Cabal (libs, exec, tests), sanboxes, repl etc. Haskell solution for [Project Euler's puzzle 217: Balanced Numbers](https://projecteuler.net/problem=217) 

#### Prepare sandbox
```
cabal sandbox init
cabal install -j4 --only-dependencies --enable-tests --force-reinstalls
cabal configure
```
#### Build/run/test/repl:
````
cabal repl
cabal build
cabal run
cabal test
```
#### Cleanup
```
cabal clean
cabal sandbox delete
```
#### Tested with
* ghc 7.4.1
* cabal-install 1.20.0.3
* cabal library 1.20.0.2

#### Known limitations
* wrong number of tests reported on tests success
* some problems with dependencies versions. `--force-reinstalls` required
* can't play with test dependencies using sandbox and repl
* test and production code doesn't use multiple threads
* no optimizations: ~4s to get result from interpreter without compilation. 