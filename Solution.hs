{-# LANGUAGE GeneralizedNewtypeDeriving, ScopedTypeVariables, BangPatterns #-}

module Solution where

--import Data.HashMap
import Data.Map
import Debug.Trace
--import Data.Hashable
--import Data.Hashable.Class.Hashable

newtype Number_of_digits = Number_of_digits {get_number_of_digits :: Int} deriving (Eq, Num, Show, Integral, Enum, Real, Ord)
newtype Number_of_numbers = Number_of_numbers {get_number_of_numbers :: Integer} deriving (Eq, Num, Show)
newtype Sum_of_digits = Sum_of_digits {get_sum_of_digits :: Int} deriving (Num, Enum, Integral, Real, Ord, Eq, Show)
newtype Sum_of_numbers = Sum_of_numbers {get_sum_of_numbers :: Integer} deriving (Show, Num, Enum)

type All_numbers_info = Map Sum_of_digits (Sum_of_numbers, Number_of_numbers)
 
all_numbers_of_size :: Number_of_digits -> Int -> All_numbers_info
all_numbers_of_size 1 from = fromList $ [(Sum_of_digits x, (Sum_of_numbers $ toInteger x, 1)) | x <- [from..9]]
all_numbers_of_size n from = 
		      fromListWith pair_of_sums $   
			[ 
			  let 
			      new_sum_of_digits = Sum_of_digits( sum_of_digits + digit)
			      new_sum_of_numbers = Sum_of_numbers (sum_of_numbers * 10 + toInteger digit * number_of_numbers)
			      new_number_of_numbers = Number_of_numbers number_of_numbers
			      in
			(new_sum_of_digits, (new_sum_of_numbers, new_number_of_numbers))
			|
			digit :: Int <- [0..9], 
			(Sum_of_digits  sum_of_digits, 
			  (Sum_of_numbers sum_of_numbers, Number_of_numbers number_of_numbers)) 
			    <- smaller_numbers]
			where 
			  smaller_numbers = toList $ all_numbers_of_size (n-1) from

-- http://stackoverflow.com/questions/9722689/haskell-how-to-map-a-tuple
pair_of_sums (a1,b1) (a2,b2) = (a1+a2, b1+b2)

combine :: All_numbers_info -> All_numbers_info -> Number_of_digits-> Bool -> Sum_of_numbers
combine begins ends ends_size add_middle_digit = 
  sum . elems $ 
  (intersectionWith (\(Sum_of_numbers sum_of_begins,Number_of_numbers  number_of_begins) 
                      (Sum_of_numbers sum_of_ends,Number_of_numbers  number_of_ends) -> 
		Sum_of_numbers (
		  (10^shift_begins_by * (sum_of_begins * number_of_ends) + (sum_of_ends * number_of_begins) )
			  -- * 10 +  10^ends_size * (sum [0..9])
			  * (if add_middle_digit then 10 else 1)
			  + (summand_of_middle_digit * number_of_begins * number_of_ends)
			 -- + if add_middle_digit then 10^ends_size * number_of_begins * number_of_ends else 0	
			  )
			  --Sum_of_numbers (10^shift_begins_by * sum_of_begins)
			  
			  )
	    begins ends)
	    --() + summand_of_middle_digit + sum_of_ends) begins ends
    where 
	      shift_begins_by = ends_size + if add_middle_digit then 1 else 0
	      summand_of_middle_digit = if add_middle_digit then (sum [0..9]) * (10 ^ends_size) else 0

-- sums n = combine (all_numbers_of_size n 1) (all_numbers_of_size n 0) 1 False


t 1 = sum [0..9]
t n = (combine (all_numbers_of_size half 1) (all_numbers_of_size half 0) half add_middle_digit) + t (n-1)
	where
	  (half, remainder) = n `divMod` 2
	  add_middle_digit = odd remainder

tm n = (get_sum_of_numbers(t n)) `mod`( 3^15)
	  