import Test.HUnit
import Text.Printf
import Solution

tests = TestList [
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
  where n --> value = TestCase $ assertEqual (printf "T(%d)" n) value (solution . Number_of_digits $ n)

main = runTestTT tests