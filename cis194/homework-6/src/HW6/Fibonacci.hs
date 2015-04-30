module HW6.Fibonacci
( -- exercise 1
  fib
, fibs1
  -- exercise 2
, fibs2
  -- exercise 3
, Stream (..)
, streamToList
  -- exercise 4
, streamRepeat
, streamMap
, streamFromSeed
) where

-- exercise 1

fib :: Integer -> Integer
fib 0 = 0
fib 1 = 1
fib n = fib (n-2) + fib (n-1)

fibs1 :: [Integer]
fibs1 = map fib [0..]

-- exercise 2

fibs2 :: [Integer]
fibs2 = 0 : 1 : zipWith (+) fibs2 (tail fibs2)

-- exercise 3

data Stream a = Cons a (Stream a)

instance Show a => Show (Stream a) where
  show stream =
      first20 ++ " (only first 20 items of stream shown)"
    where
      first20 = show . take 20 $ streamToList stream

streamToList :: Stream a -> [a]
streamToList (Cons a remaining) = a : streamToList remaining

-- exercise 4

streamRepeat :: a -> Stream a
streamRepeat x = undefined

streamMap :: (a -> b) -> Stream a -> Stream b
streamMap f stream = undefined

streamFromSeed :: (a -> a) -> a -> Stream a
streamFromSeed f init = undefined
