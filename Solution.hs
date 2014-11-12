{-# LANGUAGE GeneralizedNewtypeDeriving, ScopedTypeVariables #-}

module Solution where

import Data.HashMap
z = 4

newtype Number_of_digits = Number_of_digits {get_number_of_digits :: Int} deriving (Eq, Num, Show)
newtype Number_of_numbers = Number_of_numbers {get_number_of_numbers :: Integer} deriving (Eq, Num, Show)
newtype Sum_of_digits = Sum_of_digits {get_sum_of_digits :: Int} deriving (Num, Enum, Integral, Real, Ord, Eq, Show)
newtype Sum_of_numbers = Sum_of_numbers {get_sum_of_numbers :: Integer} deriving (Show)


all_numbers_of_size :: Number_of_digits -> [(Sum_of_digits, Sum_of_numbers)]
all_numbers_of_size 1 = [(x, Sum_of_numbers $ toInteger x) | x <- [0..9]]
all_numbers_of_size n = [ (Sum_of_digits( sum_of_digits + digit), Sum_of_numbers (sum_of_numbers * 10 + toInteger digit)) |
				digit :: Int <- [0..9], 
				(Sum_of_digits { get_sum_of_digits = sum_of_digits}, Sum_of_numbers {get_sum_of_numbers= sum_of_numbers}) <- all_numbers_of_size (n-1)]
{-
all_numbers_of_size n = foldl add_digits emptyMap [0..9]
			where
			  add_digits digitMap digit =
			  smaller_map = all_numbers_of_size n-1
			  -}

--main = return ()