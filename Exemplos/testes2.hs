import Euterpea
import Codec.Midi
import System.IO.Unsafe

m = removeEither (unsafePerformIO(importFile "despacito.mid"))

removeEither :: (Either String Midi) -> Midi
removeEither (Right a) = a
removeEither (Left a) = error a

