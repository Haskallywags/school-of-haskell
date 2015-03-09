module HW2.LogAnalysis
( parseMessage
, parse
, insert
, build
, inOrder
, whatWentWrong
) where

import Control.Applicative ((<$>))
import Control.Monad (liftM)
import Data.List (foldl', sort)
import Provided.Log
import Text.Parsec hiding (Reply (Error), parse)
import Text.Parsec.String (Parser)

import qualified Text.Parsec as Parsec

instance Ord LogMessage where
  compare (LogMessage _ t1 _) (LogMessage _ t2 _) = compare t1 t2
  compare (Unknown _) (Unknown _) = EQ
  compare _ (Unknown _) = GT
  compare (Unknown _) _ = LT

parseMessage :: String -> LogMessage
parseMessage line =
    case Parsec.parse parseLogLine "" line of
      Right msg -> msg
      Left _    -> Unknown line

parse :: String -> [LogMessage]
parse = map parseMessage . lines

insert :: LogMessage -> MessageTree -> MessageTree
insert (Unknown _) tree = tree
insert new Leaf = Node Leaf new Leaf
insert new (Node left current right) =
    if new < current
    then Node (insert new left) current right
    else Node left current $ insert new right

build :: [LogMessage] -> MessageTree
build = foldl' (flip insert) Leaf

inOrder :: MessageTree -> [LogMessage]
inOrder Leaf = []
inOrder (Node lTree msg rTree) =
    inOrder lTree ++ [msg] ++ inOrder rTree

whatWentWrong :: [LogMessage] -> [String]
whatWentWrong = map getMessage . sort . relevantErrors

-- private functions

relevantErrors :: [LogMessage] -> [LogMessage]
relevantErrors =
    filter $ \msg ->
      case msg of
        (LogMessage (Error sev) _ _) -> sev >= 50
        _ -> False

getMessage :: LogMessage -> String
getMessage (LogMessage _ _ msg) = msg
getMessage (Unknown msg) = msg

parseLogLine :: Parser LogMessage
parseLogLine = do
    logType <- parseType
    _       <- space
    logTime <- parseInt
    _       <- space
    logMsg  <- parseMsg
    return $ LogMessage logType logTime logMsg

parseType :: Parser MessageType
parseType = do
    c <- anyChar
    case c of
      'I' -> return Info
      'W' -> return Warning
      'E' -> liftM Error $ space >> parseInt
      _   -> parserZero

parseMsg :: Parser String
parseMsg = many1 anyChar

parseInt :: Parser Int
parseInt = read <$> many1 digit
