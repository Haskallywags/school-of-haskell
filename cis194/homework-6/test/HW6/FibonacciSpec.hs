module HW6.FibonacciSpec (main, spec) where

import HW6.Fibonacci (Stream (..))

import qualified HW6.Fibonacci as HW6

import Test.Hspec
import Test.QuickCheck

main :: IO ()
main = hspec spec

spec :: Spec
spec = do

  let fibList10 = [0,1,1,2,3,5,8,13,21,34]
      stream123 = 1 `Cons` 2 `Cons` 3 `Cons` stream123

  describe "exercise 1" $ do
    describe "fib" $

      it "returns the nth Fibonacci number" $
        map HW6.fib [0..9] `shouldBe` fibList10

    describe "fibs1" $

      it "returns an infinite list of all Fibonacci numbers" $
        take 10 HW6.fibs1 `shouldBe` fibList10

  describe "exercise 2" $
    describe "fibs2" $

      it "returns an infinite list of all Fibonacci numbers" $
        take 10 HW6.fibs2 `shouldBe` fibList10

  describe "exercise 3" $ do
    describe "streamToList" $

      it "turns a Stream into an infinite list" $
        take 5 (HW6.streamToList stream123) `shouldBe` [1,2,3,1,2]

    describe "Stream Show" $

      it "turns a Stream into a readable String" $
        null (show stream123) `shouldBe` False

  describe "exercise 4" $ do
    describe "streamRepeat" $

      it "makes a repeating Stream from a single element" $
          take 5 (HW6.streamToList $ HW6.streamRepeat 'x') == take 5 (repeat 'x')

    describe "streamMap" $

      it "maps a function over a Stream" $
        take 5 (HW6.streamToList $ HW6.streamMap succ stream123) `shouldBe` [2,3,4,2,3]

    describe "streamFromSeed" $

      it "creates a Stream from a seed value and function" $
        take 5 (HW6.streamToList $ HW6.streamFromSeed succ 1) `shouldBe` [1,2,3,4,5]

  describe "exercise 5" $ do
    describe "nats" $

      it "generates a Stream of natural numbers starting from 0" $
        take 5 (HW6.streamToList HW6.nats) `shouldBe` [0,1,2,3,4]

    describe "ruler" $ do
      let ruler16 = [0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,4]

      it "generates the Stream of the sequence of the ruler function" $
        take 16 (HW6.streamToList HW6.ruler) `shouldBe` ruler16
