import Euterpea;
import TextoMusica; -- É onde está guardada a música principal. Ela foi convertida pra texto usando o arquivo MidiParaMusica1TXT.hs

-- Atalhos para poder usar notas e cifras.
doh = c
reh = d
mi  = e
fa  = f
sol = g
la  = a
si  = b

-- Inverte, tira um resíduo do final, inverte denovo, tira um resíduo do começo e desacelera.
principalSolo = tempo (0.8) (retro (remove (6) (retro (remove (4.8) musicaPrincipal))))

-- Transforma em Music1 para ficar compatível com a musica principal e então desacelera.
acompanhamentoSemRepeticao = tempo (1/3) (toMusic1 (Modify(Instrument VoiceOohs)((reh 3 qn):+:(la 2 qn):+:(si 2 qn):+:(fa 2 qn):+:(sol 2 qn):+:(reh 2 qn):+:(sol 2 qn):+:(la 2 qn))))

-- Pausa
pausa = (rest 3)

-- Gera o vetor com a música principal completa
adicionaPausas :: Music1 -> Int -> [Music1]
adicionaPausas m 0 = []
adicionaPausas m n= newM:adicionaPausas newM (n - 1)
    where
        newM = (pausa:+:pausa:+:m)

-- Concatena 15 acompanhamentoSemRepeticao
acompanhamentoCompleto = times 15 acompanhamentoSemRepeticao

-- Música principal completa
principalCompleta = chord $ adicionaPausas principalSolo 3

-- Canon in D
canonInD = acompanhamentoCompleto:=:principalCompleta