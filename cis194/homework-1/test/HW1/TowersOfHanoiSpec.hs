module HW1.TowersOfHanoiSpec (main, spec) where

import HW1.TowersOfHanoi
import Test.Hspec

main :: IO ()
main = hspec spec

spec :: Spec
spec =

  describe "hanoi" $

    it "returns a list of moves required to stack pegs in order" $
      hanoi 2 'a' 'b' 'c' `shouldBe` [('a','c'), ('a','b'), ('c','b')]
