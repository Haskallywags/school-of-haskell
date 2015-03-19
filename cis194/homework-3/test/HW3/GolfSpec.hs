module HW3.GolfSpec (main, spec) where

import HW3.Golf
import Test.Hspec
import Test.QuickCheck

main :: IO ()
main = hspec spec

spec :: Spec
spec = do

  describe "skips" $ do

    it "\"ABCD\"" $
      skips "ABCD" `shouldBe` ["ABCD", "BD", "C", "D"]

    it "\"hello!\"" $
      skips "hello!" `shouldBe` ["hello!", "el!", "l!", "l", "o", "!"]

    it "[1]" $
      skips [1] `shouldBe` ([[1]] :: [[Integer]])

    it "[True, False]" $
      skips [True, False] `shouldBe` [[True, False], [False]]

    it "[]" $
      skips [] `shouldBe` ([] :: [String])

    it "`skip xs` maintains the same length as `xs`" $ property $
      \xs -> length (skips xs) == length (xs :: [Int])

  describe "localMaxima" $ do

    it "two local maxima" $
      localMaxima [2, 9, 5, 6, 1] `shouldBe` [9, 6]

    it "one local maximum" $
      localMaxima [2, 3, 4, 1, 5] `shouldBe` [4]

    it "no local maximum (always increasing)" $
      localMaxima [1, 2, 3, 4, 5] `shouldBe` []

  describe "histogram" $ do

    it "with a few numbers" $
      histogram [1, 1, 1, 5] `shouldBe` unlines
        [ " *        "
        , " *        "
        , " *   *    "
        , "=========="
        , "0123456789"
        ]

    it "with many numbers" $
      histogram [1,4,5,4,6,6,3,4,2,4,9] `shouldBe` unlines
        [ "    *     "
        , "    *     "
        , "    * *   "
        , " ******  *"
        , "=========="
        , "0123456789"
        ]
