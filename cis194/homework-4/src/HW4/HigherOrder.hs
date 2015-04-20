module HW4.HigherOrder
( Tree (..)
, fun1
, fun2
, foldTree
, xor
, map'
, myFoldl
, sieveSundaram
) where

import Data.List

data Tree a = Leaf
            | Node Integer (Tree a) a (Tree a)
            deriving (Show, Eq)

fun1 :: [Integer] -> Integer
fun1 = undefined

fun2 :: Integer -> Integer
fun2 = undefined

foldTree :: [a] -> Tree a
foldTree = undefined

xor :: [Bool] -> Bool
xor = undefined

map' :: (a -> b) -> [a] -> [b]
map' = undefined

myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl = undefined

sieveSundaram :: Integer -> [Integer]
sieveSundaram = undefined

-- private functions

cartProd :: [a] -> [b] -> [(a,b)]
cartProd xs ys = do
    x <- xs
    y <- ys
    return (x,y)
