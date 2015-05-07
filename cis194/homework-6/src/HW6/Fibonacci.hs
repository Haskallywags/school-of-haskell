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
fib = undefined

fibs1 :: [Integer]
fibs1 = undefined

-- exercise 2

fibs2 :: [Integer]
fibs2 = undefined

-- exercise 3

data Stream a = Cons a (Stream a)

instance Show a => Show (Stream a) where
  show = undefined

streamToList :: Stream a -> [a]
streamToList = undefined

-- exercise 4

streamRepeat :: a -> Stream a
streamRepeat = undefined

streamMap :: (a -> b) -> Stream a -> Stream b
streamMap = undefined

streamFromSeed :: (a -> a) -> a -> Stream a
streamFromSeed = undefined

-- exercise 5

nats :: Stream Integer
nats = undefined

ruler :: Stream Integer
ruler = undefined

-- helper functions

interleaveStreams :: Stream a -> Stream a -> Stream a
interleaveStreams (Cons x xs) (Cons y ys) =
    x `Cons` y `Cons` interleaveStreams xs ys

-- In Haskell, a two-argument function can be wrapped in backticks to become an
-- operator. Additionally, the `infixl` and `infixr` keywords allow us to set
-- the "infixity" and association of an operator. Combined, they allow us to
-- make the stream `Cons` behave identically to the list cons operator (:).
infixr 5 `Cons`
