module HW1.CreditCardSpec (main, spec) where

import HW1.CreditCard
import Test.Hspec
import Test.QuickCheck

main :: IO ()
main = hspec spec

lteZero :: Gen Integer
lteZero = suchThat arbitrary (<= 0)

spec :: Spec
spec = do

  describe "toDigits" $ do

    it "splits an integer into a list of digits" $
      toDigits 1234 `shouldBe` [1,2,3,4]

    it "returns an empty list when an Integer <= 0" $
      forAll lteZero (null . toDigits)

  describe "toDigitsRev" $ do

    it "splits an integer into a reversed list of digits" $
      toDigitsRev 1234 `shouldBe` [4,3,2,1]

    it "returns an empty list when an Integer <= 0" $
      forAll lteZero (null . toDigitsRev)

  describe "doubleEveryOther" $

    it "doubles every other integer in a list" $ do
      doubleEveryOther [8,7,6,5] `shouldBe` [16,7,12,5]
      doubleEveryOther [1,2,3] `shouldBe` [1,4,3]

  describe "sumDigits" $

    it "sums all of the digits of each integer in a list" $
      sumDigits [16,7,12,5] `shouldBe` 22

  describe "validate" $

    it "indicates whether a credit card number is valid" $ do
      validate 4012888888881881 `shouldBe` True
      validate 4012888888881882 `shouldBe` False
