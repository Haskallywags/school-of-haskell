{-# OPTIONS_GHC -fno-warn-missing-methods #-}
{-# LANGUAGE FlexibleInstances #-}

module HW6.Optional
( -- exercise 6 (optional)
  x
, fibs3
  -- exercise 7 (optional)
, Matrix (..)
, fib4
) where

import HW6.Fibonacci (Stream (..), nats, streamFromSeed, streamMap)

-- exercise 6 (optional)

x :: Stream Integer
x = undefined

instance Num (Stream Integer) where
  fromInteger = undefined
  negate      = undefined
  (+)         = undefined
  (*)         = undefined

instance Fractional (Stream Integer) where
  (/) = undefined

fibs3 :: Stream Integer
fibs3 = undefined

-- exercise 7 (optional)

data Matrix
  = Matrix Integer Integer Integer Integer
  deriving (Eq, Show)

instance Num Matrix where
  (*) = undefined

fib4 = undefined

-- helper functions

zeroes :: Stream Integer
zeroes = 0 `Cons` zeroes
