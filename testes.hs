import Euterpea

doh = c
reh = d
mi  = e
fa  = f
sol = g
la  = a
si  = b

mySong = (Modify(Instrument Gunshot)((c 4 en) :+: d 4 en :+: e 4 en :+: f 4 en :+: (rest 0.15) :+: f 4 en :+: f 4 en :+: (c 4 en) :+: d 4 en :+: (c 4 en) :+: d 4 en :+: (rest 0.1) :+: d 4 en :+: d 4 en)):=: Modify(Instrument Oboe)((c 4 (8)):+:(c 4 (8)):+:(c 4 (8)):+:(c 4 (8)):+:(c 4 (8)):+:(c 4 (8)):+:(c 4 (8)):+:(c 4 (8)))
secondSong = Modify(Instrument Ocarina)((si 4 (1/2)):+:(si 4 (1/16)):+:(fa 4 (1/16)):+:(si 4 (1/16)):+:(doh 5 (1/16)):+:(reh 5 (1/8)):+:(mi 5 (1/8)):+:(reh 5 (1/8)):+:(doh 5 (1/8)):+:(si 4 (1/8)):+:(la 4 (1/8)):+:(sol 4 (1/8)):+:(reh 5 (1/16)):+:(reh 5 (1/8)):+:(reh 5 (1/8)):+:(reh 5 1):+:(reh 5 (1/8)):+:(la 4 (1/8)):+:(reh 5 (1/8)):+:(la 4 (1/8)):+:(reh 5 (1/8)):+:(la 4 (1/8)):+:(reh 5 (1/8)):+:(mi 5 (1/16)):+:(doh 5 (1/16)):+:(doh 5 2):+:
             (si 4 (1/2)):+:(si 4 (1/16)):+:(fa 4 (1/16)):+:(si 4 (1/16)):+:(doh 5 (1/16)):+:(reh 5 (1/8)):+:(mi 5 (1/8)):+:(reh 5 (1/8)):+:(doh 5 (1/8)):+:(si 4 (1/8)):+:(la 4 (1/8)))