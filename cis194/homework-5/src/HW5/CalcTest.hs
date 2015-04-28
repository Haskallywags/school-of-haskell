module HW5.CalcTest
( testInteger
, testBool
, testMM
, testSat
) where

import HW5.Calc (Expr, lit, add, mut)
import Provided.Parser (parseExp)

testInteger :: Maybe Integer
testInteger = testExp

testBool :: Maybe Bool
testBool = testExp

testMM :: Maybe MinMax
testMM = testExp

testSat :: Maybe Mod7
testSat = testExp

-- private functions

testExp :: Expr a => Maybe a
testExp = parseExp lit add mul "(3 * -4) + 5"
