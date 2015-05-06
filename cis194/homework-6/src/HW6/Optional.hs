{-# OPTIONS_GHC -fno-warn-missing-methods #-}
{-# LANGUAGE FlexibleInstances #-}

module HW6.Optional where

import HW6.Fibonacci (Stream (..), nats, streamFromSeed, streamMap)

-- exercise 6 (optional)

x :: Stream Integer
x = 0 `Cons` 1 `Cons` zeroes

instance Num (Stream Integer) where
  fromInteger n = n `Cons` zeroes
  negate = streamMap (* (-1))
  (Cons a0 a') + (Cons b0 b') = a0 + b0 `Cons` a' + b'
  (Cons a0 a') * b@(Cons b0 b') = (a0 * b0) `Cons` streamMap (* a0) b' + a' * b

instance Fractional (Stream Integer) where
  (Cons a0 a') / (Cons b0 b') = q
    where
      q = (a0 `div` b0) `Cons` (a' - q * b') / fromInteger b0

fibs3 :: Stream Integer
fibs3 = x / (1 - x - x * x)

-- exercise 7 (optional)

data Matrix = Matrix Integer Integer Integer Integer

instance Num Matrix where
  (Matrix a b c d) * (Matrix e f g h) =
    Matrix (a * e + b * g) (a * f + b * h) (c * e + d * g) (c * f + d * h)

fib4 n = projectFn $ matrix n
  where
    matrix 0 = Matrix 1 1 1 0
    matrix fn = (matrix 0) ^ fn
    projectFn (Matrix _ fn _ _) = fn

-- helper functions

zeroes :: Stream Integer
zeroes = 0 `Cons` zeroes
