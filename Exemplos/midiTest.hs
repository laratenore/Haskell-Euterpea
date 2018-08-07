import Euterpea
import Data.Either
import Codec.Midi
import Euterpea.IO.MIDI.FromMidi2


track0 = [(0,  NoteOn 0 60 80),
          (24, NoteOff 0 60 0),
          (0,  TrackEnd)]
          
track1 = [(0,  NoteOn 0 64 80),
          (24, NoteOn 0 64 0),
          (0,  TrackEnd)]
          
myMidi = Midi { fileType = MultiTrack, 
                timeDiv  = TicksPerBeat 24, 
                tracks   = [track0, track1] }

{-fileToMusic :: [Char] -> IO Music1
fileToMusic cs = do a <- importFile cs
                    b <- (fromRight myMidi) <$> a
                    c <- pure fromMidi <*> b
                    c-}
                    
          
midiFileIOEither = importFile "midis/twinkletwinkle.mid"
midiFileIO       = (fromRight myMidi) <$> midiFileIOEither
musicIO          = pure fromMidi <*> midiFileIO
song             = musicIO >>= play