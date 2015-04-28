{-# LANGUAGE FlexibleInstances #-}

module HW5.Calc
( Expr (..)
, MinMax (..)
, Mod7 (..)
, eval
, evalStr
) where

import Provided.Parser (parseExp)

import qualified Provided.ExprT   as ExprT
import qualified Provided.StackVM as StackVM

newtype MinMax = MinMax Integer deriving (Eq, Show)
newtype Mod7 = Mod7 Integer deriving (Eq, Show)

class Expr a where
  lit :: Integer -> a
  add :: a -> a -> a
  mul :: a -> a -> a

instance Expr ExprT.ExprT where
  lit = ExprT.Lit
  add = ExprT.Add
  mul = ExprT.Mul

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

instance Expr StackVM.Program where
  lit n = [StackVM.PushI n]
  add p1 p2 = p1 ++ p2 ++ [StackVM.Add]
  mul p1 p2 = p1 ++ p2 ++ [StackVM.Mul]

eval :: ExprT.ExprT -> Integer
eval (ExprT.Lit x) = x
eval (ExprT.Add x y) = (eval x) + (eval y)
eval (ExprT.Mul x y) = (eval x) * (eval y)

evalStr :: String -> Maybe Integer
evalStr = fmap eval . parseExp ExprT.Lit ExprT.Add ExprT.Mul

compile :: String -> Maybe StackVM.Program
compile = parseExp lit add mul
