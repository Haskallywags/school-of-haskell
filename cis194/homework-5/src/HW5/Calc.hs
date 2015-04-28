{-# LANGUAGE TypeSynonymInstances #-}

module HW5.Calc
( eval
, evalStr
) where

import Provided.ExprT (ExprT (..))
import Provided.Parser (parseExp)
import Provided.StackVM

newtype MinMax = MinMax Integer deriving (Eq, Show)
newtype Mod7 = Mod7 Integer deriving (Eq, Show)

class Expr a where
  lit :: Integer -> a
  add :: a -> a -> a
  mut :: a -> a -> a

instance Expr ExprT where
  lit = Lit
  add = Add
  mut = Mut

instance Expr Integer where
  lit = id
  add = (+)
  mut = (*)

instance Expr Bool where
  lit n = n > 0
  add = (||)
  mut = (&&)

instance Expr MinMax where
  lit = MinMax
  add (MinMax x) (MinMax y) = MinMax $ max x y
  mut (MinMax x) (MinMax y) = MinMax $ min x y

instance Expr Mod7 where
  lit = Mod7
  add (Mod7 x) (Mod7 y) = Mod7 . mod 7 $ x + y
  mut (Mod7 x) (Mod7 y) = Mod7 . mod 7 $ x * y

eval :: ExprT -> Integer
eval (Lit x) = x
eval (Add x y) = (eval x) + (eval y)
eval (Mul x y) = (eval x) * (eval y)

evalStr :: String -> Maybe Integer
evalStr = fmap eval . parseExp Lit Add Mut
