module HashTests where

import Protolude

import Curve
import Pairing.Hash
import Test.QuickCheck.Instances ()
import Test.QuickCheck.Monadic
import Test.Tasty
import Test.Tasty.QuickCheck

testHash :: TestTree
testHash = testGroup "Hash"
  [ testProperty "swEncBN" prop_swEncBN
  ]

prop_swEncBN :: ByteString -> Property
prop_swEncBN bs = monadicIO $ do
  toCurveMay <- run $ swEncBN bs
  assert $ isJust toCurveMay
  let toCurve = fromMaybe (panic "unreachable.") toCurveMay
  assert $ def toCurve