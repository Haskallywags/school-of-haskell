module HW6.OptionalSpec (main, spec) where

import HW6.Fibonacci (Stream (..))
import HW6.Optional (Matrix (..))

import qualified HW6.Fibonacci  as HW6
import qualified HW6.Optional   as HW6

import Test.Hspec
import Test.QuickCheck

main :: IO ()
main = hspec spec

listFirst :: Int -> Stream Integer -> [Integer]
listFirst n = take n . HW6.streamToList

spec :: Spec
spec = do

  let fibList10 = [0,1,1,2,3,5,8,13,21,34]

  describe "exercise 6 (optional)" $ do
    describe "x" $

      it "matches the function (x = 0 + 1x + 0x2 + 0x3 + ...)" $
        listFirst 5 HW6.x `shouldBe` [0,1,0,0,0]

    describe "Num (Stream Integer)" $ do
      describe "fromInteger" $

        it "creates a Stream from an Integer" $
          listFirst 5 (fromInteger 7) `shouldBe` [7,0,0,0,0]

      describe "negate" $

        it "negates every Integer in a Stream Integer" $
          listFirst 5 (negate HW6.nats) `shouldBe` [0,-1,-2,-3,-4]

      describe "(+)" $
        it "creates a new Stream by successively adding the values of two Streams" $
          listFirst 5 (HW6.nats + HW6.nats) `shouldBe` [0,2,4,6,8]

      describe "(*)" $
        it "multiple two Streams via the formula (AB = a0b0 + x(a0B′ + A′B))" $
          listFirst 5 (HW6.nats * HW6.nats) `shouldBe` [0,0,1,4,10]

    describe "Fractional (Stream Integer)" $
      describe "(/)" $ do
        let s1 = HW6.streamFromSeed (+1) 1 :: Stream Integer
            s2 = HW6.streamFromSeed (+2) 1 :: Stream Integer

        it "divides two Streams via the formula (A/B = (a0/b0) + x((1/b0)(A′ − (A/B)B′)))" $
          listFirst 5 (s1 / s2) `shouldBe` [1,-1,1,-1,1]

    describe "fibs3" $
      it "produces a Stream of the Fibonacci numbers" $
        listFirst 10 HW6.fibs3 `shouldBe` fibList10

  describe "exercise 7 (optional)" $ do
    describe "Num Matrix" $
      describe "(*)" $

        it "multiples two matricies" $ do
          let m1 = Matrix 5 3 3 2
              m2 = Matrix 1 1 1 0

          m1 * m2 `shouldBe` Matrix 8 5 5 3

    describe "fib4" $

      it "finds the Nth Fibonacci number" $
        HW6.fib4 25 `shouldBe` 75025
