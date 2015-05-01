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
  -- exercise 5
, nats
, ruler
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
streamToList (Cons x xs) = x : streamToList xs

-- exercise 4

streamRepeat :: a -> Stream a
streamRepeat x = Cons x $ streamRepeat x

streamMap :: (a -> b) -> Stream a -> Stream b
streamMap f (Cons x xs) = f x `Cons` streamMap f xs

streamFromSeed :: (a -> a) -> a -> Stream a
streamFromSeed f x = x `Cons` streamFromSeed f (f x)

-- exercise 5

nats :: Stream Integer
nats = streamFromSeed succ 0

-- hinted at as helpful to implement `ruler`
interleaveStreams :: Stream a -> Stream a -> Stream a
interleaveStreams (Cons x xs) (Cons y ys) =
    x `Cons` (y `Cons` interleaveStreams xs ys)

ruler :: Stream Integer
ruler = ruler' $ streamRepeat 0
  where
    ruler' (Cons x xs) =
      x `Cons` interleaveStreams (ruler' . streamRepeat $ succ x) xs
