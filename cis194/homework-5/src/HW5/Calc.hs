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
eval = undefined

-- exercise 2

evalStr :: String -> Maybe Integer
evalStr = undefined

-- exercise 3

class Expr a where
  lit :: Integer -> a
  add :: a -> a -> a
  mul :: a -> a -> a

instance Expr ExprT.ExprT where
  lit = undefined
  add = undefined
  mul = undefined

-- exercise 4

newtype MinMax = MinMax Integer deriving (Eq, Show)
newtype Mod7 = Mod7 Integer deriving (Eq, Show)

instance Expr Integer where
  lit = undefined
  add = undefined
  mul = undefined

instance Expr Bool where
  lit = undefined
  add = undefined
  mul = undefined

instance Expr MinMax where
  lit = undefined
  add = undefined
  mul = undefined

instance Expr Mod7 where
  lit = undefined
  add = undefined
  mul = undefined

-- exercise 5 (optional)

instance Expr StackVM.Program where
  lit = undefined
  add = undefined
  mul = undefined

compile :: String -> Maybe StackVM.Program
compile = undefined

-- exercise 6 (optional)

data (Eq a, Show a) => VarExprT a
  = Lit Integer
  | Add (VarExprT a) (VarExprT a)
  | Mul (VarExprT a) (VarExprT a)
  | Var a
  deriving (Eq, Show)

instance (Eq a, Show a) => Expr (VarExprT a) where
  lit = undefined
  add = undefined
  mul = undefined

class HasVars a where
  var :: String -> a

instance HasVars (VarExprT String) where
  var = undefined

instance HasVars (Map.Map String Integer -> Maybe Integer) where
  var = undefined

instance Expr (Map.Map String Integer -> Maybe Integer) where
  lit = undefined
  add = undefined
  mul = undefined
