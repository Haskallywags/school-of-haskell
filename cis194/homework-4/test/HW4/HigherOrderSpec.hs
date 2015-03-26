module HW4.HigherOrderSpec (main, spec) where

import Test.Hspec
import Test.QuickCheck

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
