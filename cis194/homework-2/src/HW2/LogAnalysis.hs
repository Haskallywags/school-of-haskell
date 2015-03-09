module HW2.LogAnalysis
( parseMessage
, parse
, insert
) where

import Control.Applicative ((<$>))
import Control.Monad (liftM)
import Provided.Log
import Text.Parsec hiding (Reply (Error), parse)
import Text.Parsec.String (Parser)

import qualified Text.Parsec as Parsec

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
    if time new < time current
    then Node (insert new left) current right
    else Node left current $ insert new right

-- private functions

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

time :: LogMessage -> Int
time (LogMessage _ t _) = t
time _                  = maxBound
