{-# LANGUAGE GeneralizedNewtypeDeriving, ScopedTypeVariables, BangPatterns #-}

module Solution where

import Data.Map

newtype Number_of_digits = Number_of_digits {get_number_of_digits :: Int} deriving (Eq, Num, Show, Integral, Enum, Real, Ord)
newtype Number_of_numbers = Number_of_numbers {get_number_of_numbers :: Integer} deriving (Eq, Num, Show)
newtype Sum_of_digits = Sum_of_digits {get_sum_of_digits :: Int} deriving (Num, Enum, Integral, Real, Ord, Eq, Show)
newtype Sum_of_numbers = Sum_of_numbers {get_sum_of_numbers :: Integer} deriving (Show, Num, Enum)
type All_numbers_info = Map Sum_of_digits (Sum_of_numbers, Number_of_numbers)
 
all_numbers_of_size :: Number_of_digits -> Int -> All_numbers_info
all_numbers_of_size 1 from = fromList [(Sum_of_digits x, (Sum_of_numbers $ toInteger x, 1)) | x <- [from..9]]
all_numbers_of_size n from = fromListWith pair_of_sums $ 
           [shorter_number `extend_with` digit | shorter_number <- shorter_numbers, digit <- [0..9]]
             where
                shorter_numbers = toList $ all_numbers_of_size (n-1) from

-- http://stackoverflow.com/questions/9722689/haskell-how-to-map-a-tuple
pair_of_sums (a1,b1) (a2,b2) = (a1+a2, b1+b2)

extend_with :: (Sum_of_digits,(Sum_of_numbers,Number_of_numbers)) -> Int -> (Sum_of_digits,(Sum_of_numbers,Number_of_numbers))
extend_with (Sum_of_digits sum_of_digits, (Sum_of_numbers sum_of_numbers, Number_of_numbers number_of_numbers))
            digit = 
                (Sum_of_digits( sum_of_digits + digit),
                       (Sum_of_numbers(sum_of_numbers * 10 + toInteger digit * number_of_numbers),
                        Number_of_numbers number_of_numbers))

combine :: All_numbers_info -> All_numbers_info -> Number_of_digits-> Bool -> Sum_of_numbers
combine begins ends ends_size add_middle_digit = 
   sum . elems $ intersectionWith 
     (\(Sum_of_numbers sum_of_begins, Number_of_numbers number_of_begins) 
       (Sum_of_numbers sum_of_ends, Number_of_numbers number_of_ends)     -> 
          Sum_of_numbers (
            (10^(ends_size + extra_shift) * sum_of_begins * number_of_ends + sum_of_ends * number_of_begins) 
              * different_middle_digits
              + middle_digits_sum * 10^ends_size * number_of_begins * number_of_ends)
     )
     begins ends
     where 
      (extra_shift, middle_digits_sum, different_middle_digits) = if add_middle_digit 
                                                                  then (1, sum [0..9], 10) 
                                                                  else (0, 0, 1)

balanced 1 = sum [0..9]
balanced n = (combine (all_numbers_of_size half 1) (all_numbers_of_size half 0) half (odd n)) + balanced (n-1)
        where
          half = n `div` 2

solution n = (get_sum_of_numbers $ balanced n) `mod` 3^15