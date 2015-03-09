module HW2.LogAnalysis
( parseMessage
, parse
, insert
, build
, inOrder
, whatWentWrong
) where

import Provided.Log

parseMessage :: String -> LogMessage
parseMessage = undefined

parse :: String -> [LogMessage]
parse = undefined

insert :: LogMessage -> MessageTree -> MessageTree
insert = undefined

build :: [LogMessage] -> MessageTree
build = undefined

inOrder :: MessageTree -> [LogMessage]
inOrder = undefined

whatWentWrong :: [LogMessage] -> [String]
whatWentWrong = undefined
