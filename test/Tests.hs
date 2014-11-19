import Test.HUnit (assertEqual, (@?=))
import Text.Printf
import Test.Framework (defaultMain, testGroup)
import Test.Framework.Providers.HUnit (testCase)
import Solution

tests = [
     1 --> 45,
     2 --> 540,
     3 --> 50040,
     4 --> 3364890,
     5 --> 4771029,
     6 --> 6645504,
     7 --> 9356034,
     8 --> 4913436,
     9 --> 8361561,
     10 --> 10771919
 ]
  where n --> expected_result = testCase (printf "T(%d)" n) $ solution n @?= expected_result

main = defaultMain tests