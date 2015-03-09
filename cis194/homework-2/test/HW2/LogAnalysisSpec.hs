module HW2.LogAnalysisSpec (main, spec) where

import HW2.LogAnalysis
import Provided.Log
import Test.Hspec

main :: IO ()
main = hspec spec

spec :: Spec
spec = do

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
               , LogMessage Info 29 "la la la"
               , Unknown "This is not in the right format"
               ]

    it "parses a log file into a list of messages" $
      parse logFile `shouldBe` msgs

  describe "insert" $ do

    let m1   = LogMessage Info 1 ""
        m2   = LogMessage (Error 9000) 2 ""
        m3   = LogMessage Warning 3 ""

    it "creates a new node from a leaf and message" $
      insert m2 Leaf `shouldBe` Node Leaf m2 Leaf

    it "inserts a new node into an existing tree" $ do
      let tree1 = insert m2 $ insert m1 $ insert m3 Leaf
          tree2 = Node (Node Leaf m1 (Node Leaf m2 Leaf)) m3 Leaf
      tree1 `shouldBe` tree2

    it "ignores unknown messages" $
      insert (Unknown "") Leaf `shouldBe` Leaf

