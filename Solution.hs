{-# LANGUAGE GeneralizedNewtypeDeriving, ScopedTypeVariables, BangPatterns #-}

module Solution where

--import Data.HashMap
import Data.Map
import Debug.Trace
--import Data.Hashable
--import Data.Hashable.Class.Hashable
z = 4

newtype Number_of_digits = Number_of_digits {get_number_of_digits :: Int} deriving (Eq, Num, Show)
newtype Number_of_numbers = Number_of_numbers {get_number_of_numbers :: Integer} deriving (Eq, Num, Show)
newtype Sum_of_digits = Sum_of_digits {get_sum_of_digits :: Int} deriving (Num, Enum, Integral, Real, Ord, Eq, Show)
newtype Sum_of_numbers = Sum_of_numbers {get_sum_of_numbers :: Integer} deriving (Show, Num)

type All_numbers_info = [(Sum_of_digits, Sum_of_numbers)]

{-
instance Hashable Sum_of_digits where
  hash (Sum_of_digits {get_number_of_digits = a}) = a
  -}
  
all_numbers_of_size :: Number_of_digits -> All_numbers_info
all_numbers_of_size 1 = [(x, Sum_of_numbers $ toInteger x) | x <- [0..9]]
all_numbers_of_size n = 
	      toList . norm $ [ (Sum_of_digits( sum_of_digits + digit), Sum_of_numbers (sum_of_numbers * 10 + toInteger digit)) |
				digit :: Int <- [0..9], 
				(Sum_of_digits  sum_of_digits, Sum_of_numbers sum_of_numbers) <- smaller_numbers]
				  where
				     smaller_numbers = all_numbers_of_size (n-1)
       
				
norm :: All_numbers_info -> Map Sum_of_digits Sum_of_numbers
norm = fromListWith (+)

-- TODO middle number
combine :: All_numbers_info -> All_numbers_info -> Number_of_digits-> Sum_of_numbers
combine begins ends ends_size = undefined


{-
all_numbers_of_size n = foldl add_digits emptyMap [0..9]
			where
			  add_digits digitMap digit =
			  smaller_map = all_numbers_of_size n-1
			  -}

--main = return ()