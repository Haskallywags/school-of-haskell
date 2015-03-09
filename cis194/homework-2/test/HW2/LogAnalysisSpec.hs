module HW2.LogAnalysisSpec (main, spec) where

import HW2.LogAnalysis
import Provided.Log
import Test.Hspec

main :: IO ()
main = hspec spec

spec :: Spec
spec = do

  describe "message-parsing functions" $ do

    let errorLine   = "E 2 562 help help"
        infoLine    = "I 29 la la la"
        unknownLine = "This is not in the right format"

        logFile     = unlines [errorLine, infoLine, unknownLine]

    describe "parseMessage" $ do

      it "parses an error line" $ do
        let formatted = LogMessage (Error 2) 562 "help help"
        parseMessage errorLine `shouldBe` formatted

      it "parses an info line" $ do
        let formatted = LogMessage Info 29 "la la la"
        parseMessage infoLine `shouldBe` formatted

      it "parses an unknown line" $ do
        let formatted = Unknown "This is not in the right format"
        parseMessage unknownLine `shouldBe` formatted

    describe "parse" $ do

      let msgs = [ LogMessage (Error 2) 562 "help help"
                 , LogMessage Info      29  "la la la"
                 , Unknown                  "This is not in the right format"
                 ]

      it "parses a log file into a list of messages" $
        parse logFile `shouldBe` msgs

  describe "tree-operating functions" $ do

    let m1 = LogMessage Info         1 ""
        m2 = LogMessage (Error 9000) 2 ""
        m3 = LogMessage Warning      3 ""

        m2m1m3 = Node (Node Leaf m1 (Node Leaf m2 Leaf)) m3 Leaf

    describe "insert" $ do

      it "creates a new node from a leaf and message" $
        insert m2 Leaf `shouldBe` Node Leaf m2 Leaf

      it "inserts a new node into an existing tree" $ do
        let inserts = insert m2 $ insert m1 $ insert m3 Leaf
        inserts `shouldBe` m2m1m3

      it "ignores unknown messages" $
        insert (Unknown "") Leaf `shouldBe` Leaf

    describe "build" $

      it "creates a tree from a list of messages" $
        build [m3,m1,m2] `shouldBe` m2m1m3

    describe "inOrder" $

      it "desconstructs a tree into an ordered list" $
        inOrder m2m1m3 `shouldBe` [m1,m2,m3]

  describe "error-transcribing functions" $ do

    let e1 = LogMessage (Error 100) 1   "e1"
        e2 = LogMessage (Error 50)  10  "e2"
        e3 = LogMessage (Error 75)  100 "e3"
        ex = LogMessage (Error 49)  50  "ex"
        mx = LogMessage Warning     75  "mx"

        msgs = [e3, mx, e1, ex, e2]

    describe "whatWentWrong" $

      it "displays the messages of relevant errors ordered by time" $ do
        whatWentWrong msgs `shouldBe` ["e1", "e2", "e3"]
