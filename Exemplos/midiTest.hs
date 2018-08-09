import Euterpea
import Codec.Midi
                   
playFromMidi :: IO (Either String Midi) -> IO ()
playFromMidi a = a >>= playMidi'
    where
        playMidi' :: (Either String Midi) -> IO ()
<<<<<<< HEAD
        playMidi' (Right a) = play $ fromMidi a
=======
        playMidi' (Right a) = play $ (fromMidi a)
>>>>>>> 20d3ec339f0a2a81411ff60f823d75ac9bad2fe5
        playMidi' (Left a)  = error a

playFromPath :: IO ()
playFromPath = do putStr "Digite o diretorio do arquivo: " 
                  cs <- getLine
                  playFromMidi $ importFile cs
                  
