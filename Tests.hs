-- {-# OPTIONS_GHC -F -pgmF htfpp #-}

import Test.HUnit
import qualified Distribution.TestSuite as Cabal
--import qualified Distribution.TestSuite.HUnit as CabalHUnit
-- import Test.Framework
import Solution

tests2 = TestList [
  
  TestCase $ do 
	      a <- return 1
	      let b = 2
	      assertEqual "first test" a b,
  TestLabel "with label" $ TestCase (assertEqual "second test" 3 4),
  TestCase $ assertEqual "3rd test" 5 6,
  TestCase $ assertEqual "solution test" z 4
 

 ]

-- test_nonEmpty = assertEqual 1 2

main = runTestTT tests2

--tests = map (\(x,y) -> CabalHUnit.test x y) [("Login tests", tests2)]