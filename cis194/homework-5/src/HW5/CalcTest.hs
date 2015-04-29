module HW5.CalcTest
( testInteger
, testBool
, testMM
, testSat
, testProgram
, withVars
) where

import Provided.Parser (parseExp)
import Provided.StackVM (Program)

import qualified Data.Map as Map

import HW5.Calc

testInteger :: Maybe Integer
testInteger = testExp

testBool :: Maybe Bool
testBool = testExp

testMM :: Maybe MinMax
testMM = testExp

testSat :: Maybe Mod7
testSat = testExp

testProgram :: Maybe Program
testProgram = testExp

withVars :: [(String, Integer)]
         -> (Map.Map String Integer -> Maybe Integer)
         -> Maybe Integer
withVars dict expression = expression $ Map.fromList dict

-- private functions

testExp :: Expr a => Maybe a
testExp = parseExp lit add mul "(3 * -4) + 5"
