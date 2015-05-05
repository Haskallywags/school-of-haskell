{-# OPTIONS_GHC -fno-warn-missing-methods #-}
{-# LANGUAGE FlexibleInstances #-}

module HW6.Optional where

import HW6.Fibonacci (Stream (..), streamMap)

x :: Stream Integer
x = 0 `Cons` 1 `Cons` zeroes

instance Num (Stream Integer) where
  fromInteger n = n `Cons` zeroes
  negate = streamMap (* (-1))
  (Cons x xs) + (Cons y ys) = x + y `Cons` xs + ys
  (Cons x xs) * (Cons y ys) = x * y `Cons` streamMap (*x) ys + streamMap (*y) xs

instance Fractional (Stream Integer) where
  (Cons x xs) / (Cons y ys) = x/y




-- private functions

zeroes :: Stream Integer
zeroes = 0 `Cons` zeroes
