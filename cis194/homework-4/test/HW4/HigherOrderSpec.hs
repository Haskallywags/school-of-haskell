module HW4.HigherOrderSpec (main, spec) where

import Data.List (sort)
import HW4.HigherOrder (Tree (..))
import Test.Hspec
import Test.QuickCheck
import Test.QuickCheck.Function

import qualified HW4.HigherOrder as HW4

fun1 :: [Integer] -> Integer
fun1 [] = 1
fun1 (x:xs)
    | even x = (x - 2) * fun1 xs
    | otherwise = fun1 xs

fun2 :: Integer -> Integer
fun2 1 = 0
fun2 n
    | even n = n + fun2 (n `div` 2)
    | otherwise = fun2 (3 * n + 1)

treeHeightForList :: [Int] -> Integer
treeHeightForList l = ceiling . logBase (2 :: Float) . fromIntegral $ length l + 1

heightForTree :: Tree Int -> Integer
heightForTree (Node h _ _ _) = h + 1
heightForTree _              = 0

isBalanced :: Tree Int -> Bool
isBalanced Leaf = True
isBalanced (Node _ left _ right) =  isBalanced left
                                 && isBalanced right
                                 && abs (heightForTree left - heightForTree right) <= 1

treeEles :: Tree Int -> [Int]
treeEles Leaf = []
treeEles (Node _ left x right) = treeEles left ++ [x] ++ treeEles right

main :: IO ()
main = hspec spec

spec :: Spec
spec = do

  describe "fun1" $

    it "has equal results to the predefined fun1" $
      property $ \ns -> HW4.fun1 ns == fun1 ns

  describe "fun2" $

    it "has equal results to the predefined fun2" $
      property $ \(Positive n) -> HW4.fun2 n == fun2 n

  describe "foldTree" $ do

    it "must result in a balanced tree" $
      property $ \l -> isBalanced (HW4.foldTree l)

    it "contains the height in the root node" $
      property $ \l -> heightForTree (HW4.foldTree l) == treeHeightForList l

    it "contains the same elements as the list it folds" $
      property $ \l -> sort l == (sort . treeEles $ HW4.foldTree l)

  describe "xor" $

    it "returns a bool based on the number of \"True\" values" $ do
      HW4.xor [False, True, False] `shouldBe` True
      HW4.xor [False, True, False, False, True] `shouldBe` False

  describe "map'" $ do
    let sameFuncs :: (Fun Int Int, [Int]) -> Bool
        sameFuncs (f, xs) = HW4.map' (apply f) xs == map (apply f) xs

    it "behaves exactly as \"map\"" $
      property sameFuncs

  describe "myFoldl" $ do
    let sameFuncs :: [Int] -> Bool
        sameFuncs xs = HW4.myFoldl append [] xs == foldl append [] xs
        append acc x = acc ++ [x]

    it "behaves exactly as \"foldl\"" $
      property sameFuncs

  describe "sieveSundaram" $

    it "returns a list of primes up to 2n+1" $
      HW4.sieveSundaram 3 `shouldBe` [2,3,5,7]
