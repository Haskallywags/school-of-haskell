module HW5.CalcSpec (main, spec) where

import Provided.Parser (parseExp)

import qualified Data.Map         as Map
import qualified HW5.Calc         as HW5
import qualified Provided.ExprT   as ExprT
import qualified Provided.StackVM as StackVM

import Test.Hspec
import Test.QuickCheck

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  let exprT = ExprT.Mul (ExprT.Add (ExprT.Lit 2) (ExprT.Lit 3)) (ExprT.Lit 4)
      expr  = HW5.mul (HW5.add (HW5.lit 2) (HW5.lit 3)) (HW5.lit 4)

  describe "exercise 1" $
    describe "eval" $

      it "resolves an ExprT to an integer" $
        HW5.eval exprT `shouldBe` 20

  describe "exercise 2" $
    describe "evalStr" $ do
      let valid   = "(2 + 3) * 4"
          invalid = "(2 +) * 4"

      it "returns an integer for a valid expression" $
        HW5.evalStr valid `shouldBe` Just 20

      it "returns \"Nothing\" for an invalid expression" $
        HW5.evalStr invalid `shouldBe` Nothing

  describe "exercise 3" $
    describe "Expr ExprT" $

      it "returns the same expression for the instance of ExprT" $
        expr `shouldBe` exprT

  describe "exercise 4" $ do
    describe "Expr Integer" $

      it "resolves an integer from an Expr" $
        testInteger `shouldBe` Just (-7)

    describe "Expr Bool" $

      it "resolves a boolean from an Expr" $
        testBool `shouldBe` Just True

    describe "Expr MinMax" $

      it "resolves a MinMax from an Expr" $
        testMM `shouldBe` Just (HW5.MinMax 5)

    describe "Expr Mod7" $

      it "resolves a Mod7 from an Expr" $
        testSat `shouldBe` Just (HW5.Mod7 0)

  describe "exercise 5 (optional)" $
    describe "compile" $ do
      let program =
            [ StackVM.PushI 3
            , StackVM.PushI (-4)
            , StackVM.Mul
            , StackVM.PushI 5
            , StackVM.Add
            ]

      it "resolves a freakin' program from an Expr holy crap" $
        testProgram `shouldBe` Just program

  describe "exercise 6 (optional)" $
    describe "VarExprT" $ do
      let stack   = [("x", 6)]
          valid   = HW5.add (HW5.lit 3) (HW5.var "x")
          invalid = HW5.add (HW5.lit 3) (HW5.var "y")

      it "resolves the expression when all variables exist" $
        withVars stack valid `shouldBe` Just 9

      it "returns Nothing when a variable is missing" $
        withVars stack invalid `shouldBe` Nothing

-- private functions

testInteger = testExp :: Maybe Integer
testBool    = testExp :: Maybe Bool
testMM      = testExp :: Maybe HW5.MinMax
testSat     = testExp :: Maybe HW5.Mod7
testProgram = testExp :: Maybe StackVM.Program

testExp :: HW5.Expr a => Maybe a
testExp = parseExp HW5.lit HW5.add HW5.mul "(3 * -4) + 5"

withVars :: [(String, Integer)]
         -> (Map.Map String Integer -> Maybe Integer)
         -> Maybe Integer
withVars dict expression = expression $ Map.fromList dict
