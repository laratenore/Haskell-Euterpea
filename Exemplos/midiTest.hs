import Euterpea
import Codec.Midi
                   
playFromMidi :: IO (Either String Midi) -> IO ()
playFromMidi a = a >>= playMidi'
    where
        playMidi' :: (Either String Midi) -> IO ()
        playMidi' (Right a) = play $ (fromMidi a)
        playMidi' (Left a)  = error a

playFromPath :: IO ()
playFromPath = do putStr "Digite o diretorio do arquivo: " 
                  cs <- getLine
                  playFromMidi $ importFile cs
                  
