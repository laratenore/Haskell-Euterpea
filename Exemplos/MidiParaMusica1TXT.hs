import Euterpea
import Codec.Midi
import System.IO.Unsafe

-- Recebe o diretório de um Midi e um nome para um arquivo de texto, converte o Midi para Music1 e escreve a música em um txt.
writeMusicInTxt :: String -> String -> IO ()
writeMusicInTxt dir filename = do a <- removeEither <$> (importFile dir)
                                  writeFile filename (show (fromMidi a))
        where
            -- Remove o Either
            removeEither :: (Either String Midi) -> Midi
            removeEither (Right a) = a
            removeEither (Left a) = error a