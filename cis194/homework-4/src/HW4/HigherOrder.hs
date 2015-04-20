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

import Data.List (foldl', unfoldr, filter, notElem)

data Tree a = Leaf
            | Node Integer (Tree a) a (Tree a)
            deriving (Show, Eq)

fun1 :: [Integer] -> Integer
fun1 = product . map (flip (-) 2) . filter even

fun2 :: Integer -> Integer
fun2 = sum . unfoldr wat
  where
    wat n | n <= 1    = Nothing
          | even n    = Just (n, n `div` 2)
          | otherwise = Just (0, 3 * n + 1)

foldTree :: [a] -> Tree a
foldTree = foldr insert Leaf

xor :: [Bool] -> Bool
xor = foldr (const not) False . filter id

map' :: (a -> b) -> [a] -> [b]
map' f = foldr (\x ys -> f x : ys) []

myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl f = foldr (flip f)

sieveSundaram :: Integer -> [Integer]
sieveSundaram n =
    2 : keeps
  where
    deletes = map (\(x,y) -> x+y+2*x*y) $ cartProd [1..n] [1..n]
    keeps = map (\x -> 2*x+1) $ filter (flip notElem deletes) [1..n]

-- private functions

cartProd :: [a] -> [b] -> [(a,b)]
cartProd xs ys = do
    x <- xs
    y <- ys
    return (x,y)

insert :: a -> Tree a -> Tree a
insert x Leaf = Node 0 Leaf x Leaf
insert x (Node _ left x' right)
    | weight left < weight right =
      let left' = insert x left
      in  Node (newHeight left' right) left' x' right
    | otherwise =
      let right' = insert x right
      in  Node (newHeight left right') left x' right'

height :: Tree a -> Integer
height (Node h _ _ _) = h + 1
height _              = 0

weight :: Tree a -> Integer
weight Leaf = 0
weight (Node _ left _ right) = 1 + weight left + weight right

newHeight :: Tree a -> Tree a-> Integer
newHeight l r = maximum [height l, height r]
