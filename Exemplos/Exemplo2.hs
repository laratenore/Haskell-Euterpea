module Exemplo2 where

import Euterpea
import Codec.Midi
                                      
playFromMidi :: (Music1 -> Music1) -> IO (Either String Midi) -> IO ()
playFromMidi f a = a >>= playMidi' f

playMidi' :: (Music1 -> Music1) -> (Either String Midi) -> IO ()
playMidi' f (Right b) = play (f (fromMidi b))
playMidi' f (Left b)  = error b

playFromPath :: (Music1 -> Music1) -> IO ()
playFromPath f = do putStr "Digite o diretorio do arquivo: " 
                    cs <- getLine
                    playFromMidi f (importFile cs)