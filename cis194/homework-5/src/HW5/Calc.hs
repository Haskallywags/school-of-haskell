{-# LANGUAGE TypeSynonymInstances #-}

module HW5.Calc
( Expr (..)
, MinMax (..)
, Mod7 (..)
, eval
, evalStr
) where

import Provided.Parser (parseExp)

import qualified Provided.ExprT   as E
import qualified Provided.StackVM as S

newtype MinMax = MinMax Integer deriving (Eq, Show)
newtype Mod7 = Mod7 Integer deriving (Eq, Show)

class Expr a where
  lit :: Integer -> a
  add :: a -> a -> a
  mul :: a -> a -> a

instance Expr E.ExprT where
  lit = E.Lit
  add = E.Add
  mul = E.Mul

instance Expr Integer where
  lit = id
  add = (+)
  mul = (*)

instance Expr Bool where
  lit n = n > 0
  add = (||)
  mul = (&&)

instance Expr MinMax where
  lit = MinMax
  add (MinMax x) (MinMax y) = MinMax $ max x y
  mul (MinMax x) (MinMax y) = MinMax $ min x y

instance Expr Mod7 where
  lit = Mod7
  add (Mod7 x) (Mod7 y) = Mod7 . mod 7 $ x + y
  mul (Mod7 x) (Mod7 y) = Mod7 . mod 7 $ x * y

eval :: E.ExprT -> Integer
eval (E.Lit x) = x
eval (E.Add x y) = (eval x) + (eval y)
eval (E.Mul x y) = (eval x) * (eval y)

evalStr :: String -> Maybe Integer
evalStr = fmap eval . parseExp E.Lit E.Add E.Mul
