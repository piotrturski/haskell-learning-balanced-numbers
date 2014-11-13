{-# LANGUAGE GeneralizedNewtypeDeriving, ScopedTypeVariables, BangPatterns #-}

module Solution where

--import Data.HashMap
import Data.Map
import Debug.Trace
--import Data.Hashable
--import Data.Hashable.Class.Hashable
z = 4

newtype Number_of_digits = Number_of_digits {get_number_of_digits :: Int} deriving (Eq, Num, Show, Integral, Enum, Real, Ord)
newtype Number_of_numbers = Number_of_numbers {get_number_of_numbers :: Integer} deriving (Eq, Num, Show)
newtype Sum_of_digits = Sum_of_digits {get_sum_of_digits :: Int} deriving (Num, Enum, Integral, Real, Ord, Eq, Show)
newtype Sum_of_numbers = Sum_of_numbers {get_sum_of_numbers :: Integer} deriving (Show, Num, Enum)

type All_numbers_info = Map Sum_of_digits Sum_of_numbers

{-
instance Hashable Sum_of_digits where
  hash (Sum_of_digits {get_number_of_digits = a}) = a
  -}
  
all_numbers_of_size :: Number_of_digits -> Int -> All_numbers_info
all_numbers_of_size 1 from = fromList $ [(Sum_of_digits x, Sum_of_numbers $ toInteger x) | x <- [from..9]]
all_numbers_of_size n from = 
		      fromListWith (+) $ [ (Sum_of_digits( sum_of_digits + digit), Sum_of_numbers (sum_of_numbers * 10 + toInteger digit)) |
				digit :: Int <- [0..9], 
				(Sum_of_digits  sum_of_digits, Sum_of_numbers sum_of_numbers) <- smaller_numbers]
				  where
				     smaller_numbers = toList $ all_numbers_of_size (n-1) from
       
				
--norm :: All_numbers_info -> Map Sum_of_digits Sum_of_numbers
norm = undefined

-- TODO middle number
combine :: All_numbers_info -> All_numbers_info -> Number_of_digits-> Bool -> Sum_of_numbers
combine begins ends ends_size add_middle_number = 
  sum $
  elems $
  intersectionWith (\sum_of_begins sum_of_ends -> 10^shift_begins_by * sum_of_begins + summand_of_middle_digit + sum_of_ends) begins ends
  where 
    shift_begins_by = ends_size + if add_middle_number then 1 else 0
    summand_of_middle_digit = if add_middle_number then (sum [i * 10 ^ends_size |i <-[0..9]])  else 0

sums n = combine (all_numbers_of_size n 1) (all_numbers_of_size n 0) 1 False

{-
all_numbers_of_size n = foldl add_digits emptyMap [0..9]
			where
			  add_digits digitMap digit =
			  smaller_map = all_numbers_of_size n-1
			  -}

--main = return ()