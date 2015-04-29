{-# LANGUAGE FlexibleInstances #-}

module HW5.Calc
( -- exercise 1
  eval
  -- exercise 2
, evalStr
  -- exercise 3
, Expr (..)
  -- exercise 4
, MinMax (..)
, Mod7 (..)
  -- exercise 5 (optional)
, compile
  -- exercise 6 (optional)
, HasVars (var)
, VarExprT (..)
) where

import Provided.Parser (parseExp)

import qualified Data.Map         as Map
import qualified Provided.ExprT   as ExprT
import qualified Provided.StackVM as StackVM

-- exercise 1

eval :: ExprT.ExprT -> Integer
eval (ExprT.Lit x) = x
eval (ExprT.Add x y) = (eval x) + (eval y)
eval (ExprT.Mul x y) = (eval x) * (eval y)

-- exercise 2

evalStr :: String -> Maybe Integer
evalStr = fmap eval . parseExp ExprT.Lit ExprT.Add ExprT.Mul

-- exercise 3

class Expr a where
  lit :: Integer -> a
  add :: a -> a -> a
  mul :: a -> a -> a

instance Expr ExprT.ExprT where
  lit = ExprT.Lit
  add = ExprT.Add
  mul = ExprT.Mul

-- exercise 4

newtype MinMax = MinMax Integer deriving (Eq, Show)
newtype Mod7 = Mod7 Integer deriving (Eq, Show)

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
  add (Mod7 x) (Mod7 y) = Mod7 $ mod (x + y) 7
  mul (Mod7 x) (Mod7 y) = Mod7 $ mod (x * y) 7

-- exercise 5 (optional)

instance Expr StackVM.Program where
  lit n = [StackVM.PushI n]
  add p1 p2 = p1 ++ p2 ++ [StackVM.Add]
  mul p1 p2 = p1 ++ p2 ++ [StackVM.Mul]

compile :: String -> Maybe StackVM.Program
compile = parseExp lit add mul

-- exercise 6 (optional)

data (Eq a, Show a) => VarExprT a
  = Lit Integer
  | Add (VarExprT a) (VarExprT a)
  | Mul (VarExprT a) (VarExprT a)
  | Var a
  deriving (Eq, Show)

instance (Eq a, Show a) => Expr (VarExprT a) where
  lit = Lit
  add = Add
  mul = Mul

class HasVars a where
  var :: String -> a

instance HasVars (VarExprT String) where
  var = Var

instance HasVars (Map.Map String Integer -> Maybe Integer) where
  var = Map.lookup

instance Expr (Map.Map String Integer -> Maybe Integer) where
  lit n _ = Just n
  add fx fy dict = (+) <$> fx dict <*> fy dict
  mul fx fy dict = (*) <$> fx dict <*> fy dict
