module HW4.HigherOrder
( fun1
, fun2
) where

import Data.List (unfoldr)

fun1 :: [Integer] -> Integer
fun1 = product . map (flip (-) 2) . filter even

fun2 :: Integer -> Integer
fun2 = sum . unfoldr wat
  where
    wat n | n <= 1    = Nothing
          | even n    = Just (n, n `div` 2)
          | otherwise = Just (0, 3 * n + 1)


