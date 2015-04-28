module HW5.CalcSpec (main, spec) where

import Test.Hspec
import Test.QuickCheck

import qualified HW5.Calc as HW5

main :: IO ()
main = hspec spec

spec :: Spec
spec = return
