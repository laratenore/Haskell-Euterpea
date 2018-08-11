import Euterpea
import Codec.Midi
import System.IO.Unsafe

removeEither :: (Either String Midi) -> Midi
removeEither (Right a) = a
removeEither (Left a) = error a

m = removeEither (unsafePerformIO(importFile "canon.mid"))