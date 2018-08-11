# Euterpea

## Computer music e a biblioteca Euterpea

  Música e computação podem estar estritamente relacionados quando o que os une é matemática. Neste sentido, em Haskell, considerada uma linguagem com sintaxes e funções parecidas com notações matemáticas, existe uma biblioteca específica para uso, tratamento e composição de música chamada Euterpea. O nome Euterpea tem origem do palavra Euterpe, nome de uma das nove musas gregas, deusa das artes e musa da música. 

  Tratando-se de música, as menores entidades musicais consideradas  são as notas, ou seja, tudo é montado a partir desta entidade. Com notas é possível trabalhar desde construções simples de composições até uso harmônicos e estudo de análise rítmica. Por meio de poderosos recursos de abstração de dados, funções de alta ordem e semântica declarativa, o Haskell tem a capacidade de abranger os possíveis usos de notas musicais com computer music.

## Instalação

  Para o uso da biblioteca Euterpea, antes é necessário ter instalado no computador o Haskell e o Cabal. Para instalar a biblioteca, são utilizadas as seguintes linhas de comando no Command Prompt ou no terminal:

```
cabal update

cabal install Euterpea
```

  Esta instalação simples da biblioteca já permite que o Haskell identifique notas e instrumentos, além de reconhecimento de arquivos MIDI como explicaremos nas próximas sessões.


## Composição de músicas

  Com a biblioteca Euterpea é possível escrever músicas baseadas em notas simples. Para trabalhar com este tipo de composição é necessário ter conhecimento dos três conceitos básicos principais explicados abaixo:

* Tratando-se de teoria musical, uma nota é composta por um Pitch (tom ou oitava) e por uma duration (duração). Uma nota na biblioteca é do tipo Music Pitch.

* Na biblioteca Euterpea existem duas funções principais: note e rest.

```
note :: Dur → Pitch → Music Pitch
rest :: Dur → Music Pitch
```

  Assim, note p d pode ser lido como uma nota de duração d e oitava p. Da mesma forma, rest d é uma pausa de duração d.

* Para composição de músicas, ao combinar notas usa-se os seguintes operadores:
 ``` 
 (:+:) :: Music Pitch → Music Pitch → Music Pitch
 (:=:) :: Music Pitch → Music Pitch → Music Pitch
 ```
 Assim, n1 :+: n2 é uma música que toca primeiro a nota n1 seguido da nota n2. Por outro lado, n1 :=: n2 é uma música que toca as notas n1 e n2 ao mesmo tempo, ou seja, em paralelo.
 
Vale ressaltar que as notas são convertidas da seguinte forma:

Dó → c  /  Ré → d  /  Mi → e  /  Fá → f  /  Sol → g  /  Lá → a  /  Si → b

  Por fim, a biblioteca Euterpea usa como instrumento default o piano, mas é possível escolher um instrumento. É possível obter a lista de instrumentos possíveis pelo GHCI usando os seguintes comandos:

```
import Euterpea
:i InstrumentName
 ```
 ### Modificar instrumento
 
   * Para definir o instrumento é necessário usar o construtor "Modify" junto ao nome do instrumento, da seguinte forma:
 ```
 Modify :: Control -> Music a -> Music a
 ```
 Na definição de Modify, o construtor recebe uma entrada do tipo Control que no caso da biblioteca Euterpea é a Instrument InstrumentName
  ```
 mySong = Modify(Instrument  nome_do_instrumento)(composição)
  ```
  Dessa forma, Modify funciona como um construtor do tipo música que aplica o instrumento em toda a composição. É possível definir o instrumento no algoritmo diretamente na composição ou ao compilar a composição, como veremos em exemplos abaixo.
  
  ### Funções
  
  * Para inverter uma música, existe a função "retro" definida por:
  
  ```
  retro :: Music a -> Music a
  ```
  Dessa forma, retro mySong toca a música mySong de trás para frente.
  
  * Para acelerar ou desacelerar uma música, usa-se a função tempo:
  
  ```
  tempo   :: Dur -> Music a -> Music a
  ```
  
 Dessa forma, tempo recebe um número que divide a duração de cada nota na música. Assim, tempo 2 mySong divide o tempo das notas por 2, acelerando a música, reduzindo pela metade o tempo de execução da música. Por outro lado, tempo (1/2) mySong desacelera a música pois multiplica por 2 cada nota, duplicando o tempo de execução. 
 * Para tocar músicas ou notas diferentes em sequência
 
 ```
 line :: [Music a] → Music a
 line [ ]      = rest 0
 line (m : ms) = m :+: line ms
 ```
 A função line recebe uma lista de notas ou de composições e concatenas ela usando o operador :+: de forma a reproduzir cada item da lista em sequência. Dessa forma, line [m1,m2,m3] reproduz m1 :+: m2 :+: m3.
 
 * Para tocar músicas diferentes em paralelo
 
 ```
 chord     :: [Music a] -> Music a
 chord [ ]      = rest 0
 chord (m : ms) = m :=: chord ms
 ```
 
A função chord recebe uma lista de composições e reproduz as composições em paralelo como saída. Assim, chord [m1,m2,m3] reproduz a composição m1 :=: m2 :=: m3, pois para uma lista com pelo menos um item, chord é aplicada recursivamente compondo cada item em paralelo (:=:) com os próximos itens da lista. 

* Para inverter a ordem das notas por tons

```
invert :: Music Pitch -> Music Pitch
```
A função invert é usada para inverter a ordem das notas de forma que Dó continua como Dó, Ré passa a ser interpretado como Si, Mi passa a ser intepretado como Lá, e assim por diante, ou seja, inverte a ordem original das notas. Essa inversão leva em consideração o número de tons entre duas notas. Dessa forma, se invert receber apenas uma nota, retornará está mesma nota, porém, se invert recebe duas notas que possuem x tons entre elas, a segunda nota é convertida para a nota que se encontra a x tons anteriores a primeira nota, usada como referência pela função.

  
  * Para remover uma duração inicial da música:
 
  ```
  remove :: Dur -> Music a -> Music a
  ```
   A função remove recebe um número e uma música. Este número é correspondete ao tempo da música que deseja remover. Este tempo toma como referencia o inicio da música.
   
   * Cortar uma parte da música:
   
   ```
   cut :: Dur -> Music a -> Music a
   ```
   
   A função cut recorta uma duração da música a partir do inicio. Assim, ```cut 8 mySong``` retorna os 8 segundos iniciais de mySong.

 ## Exemplo e compilação
  Tomando como exemplo o código do arquivo "Exemplo1.hs", a compilação e teste da composição "secondSong" pode ser dada da seguinte forma:
  
  * Importando o arquivo no GHCI:
  ```
  ghci Exemplo1.hs
  ```
  ou 
  ```
  ghci 
  :l Exemplo1.hs
  ```
  
  * Tocar a música "despacito":
  ```
  play despacito
  ```
  
  * Tocar música com outro instrumento (funciona apenas se o instrumento não está já definido na composição):
  
  ```
  (play . Modify(Instrument Ocarina)) despacito
  ```
  * Tocar a música de trás para frente:
  ```
  (play . retro) despacito
  ```
  
  * Acelerar ou desacelerar uma música, respectivamente:
  ```
  (play . tempo (2) ) despacito
  ```
  ```
  (play . tempo (1/2) ) despacito
  ```
  
  * Tocar uma lista de composições em paralelo
  ```
  play  (chord [doReMiFa, despacito])
  ```
  
  * Tocar uma música com as notas invertidas de acordo com os tons:
  
  ```
  (play . invert) despacito
  ```
  
  ## Usando arquivos MIDI com Euterpea
  
  Além de composições, a biblioteca Euterpea pode ser usada para leitura, reprodução e criação de arquivos MIDI. Arquivos MIDI são arquivos no formato Musical Instrument Digital Interface, ou seja, não são arquivos de áudio, mas sim um protocolo de comunicação entre um instrumento e um módulo ou um hardware que não contem dados de audio, e sim instruções de como produzi-lo. 
  
 Usando o arquivo midiTest.hs é possível reproduzir um arquivo MIDI no GHCI usando os seguintes comandos:
 
 ```
 ghci midiTest.hs
 ```
 ```
 playFromPath (id.funcao)
 ```
 O primeiro comando é usado para que o GHCI leia o arquivo que você usará para reproduzir o MIDI. O segundo comando é para enviar para o algoritmo o MIDI que você quer que seja reproduzido junto a função que deseja aplicar ao MIDI. Neste comando, playFilePath é o nome de uma função do algoritmo que solicita o caminho do diretório onde se encontra o seu arquivo MIDI seguido pelo nome do arquivo MIDI. Caso queira reproduzir o MIDI sem aplicar nenhuma função, basta chamar ```playFromPath id ``` e escrever o diretorio e nome do arquivo quando solicitado (ex: dir1/dir2/nome_do_midi.mid).
 
  Antes de ser reproduzido, o arquivo MIDI precisa ser tratado devido a forma como entra no programa. Por ser uma entrada externa ao programa, o arquivo entra com o tipo IO. Além disso, o arquivo de entrada pode ser tanto um MIDI quanto uma string (arquivo de texto), então o arquivo também entra com o tipo Either de forma que Right representa o arquivo MIDI e Left uma string (txt). No segundo caso, o programa retorna um erro pois a intenção é reproduzir apenas no caso Right. 
  
  Para que o programa consiga reproduzir o arquivo, a função playFromMidi é usada para retirar o IO e o Either. Esta função é defininda como:
  ```
  playFromMidi :: IO (Either String Midi) -> IO ()
  ```
  PlayFromMidi retorna apenas a saída em formato de som (IO) que ocorre devido a combinação da função play com a função fromMidi aplicada no arquivo de entrada. A função fromMidi transforma o arquivo de entrada para um texto no formato de composição, com notas, intervalos, rests e instrumentos, ou seja, no formato Music1 que pode ser reproduzido com play, como vimos na sessão anterior. Abaixo apresentamos a definição de play e de fromMidi para melhor compreensão:
  
  ```
  play :: Performable a => Music a → IO ()
  ```
   ```
  fromMidi :: Codec.Midi.Midi -> Music1
  ```
 ## Modificando Instrumento de MIDI
 
 Como dito anteriormente, a função ```Modify (Instrument nome_do_instumento)``` não pode ser usada em músicas que já tem instrumentos definidos. Como todos os MIDIs já possuem um ou mais instrumentos, para modificá-los existe a função changeInstrument:
 
 ```
 changeInstrument :: InstrumentName -> Music a -> Music a
 ```
 
 Dessa forma, ```playFromPath (id.changeInstrument Ocarina)``` toca a música indicada pelo diretório no instrumento Ocarina.
 
### De composição para MIDI

  Como visto no ultimo tópico, um dos passos para que o Haskell consiga reproduzir um MIDI é o uso da função fromMidi que transforma o arquivo em uma composição. O caminho inverso também é possível com o uso da função "writeMidi":
  
  
  ```
  writeMidi :: ToMusic1 a => FilePath -> Music a -> IO ()
  ```
 
 Dessa forma, writeMidi recebe um caminho para um diretorio (FilePath) e uma composição do tipo Music a. Se temos a composição mySong, writeMidi "dir1/dir2/mySongMIDI.mid" mySong transforma a composição em um arquivo MIDI criado no diretório "dir1/dir2" com o nome "mySongMIDI.mid".
 
 
## Exemplo: Canon in D

No arquivo "Canon.hs" apresentamos uma maneira de reproduzir a música Canon in D de Johann Pachelbel. Está música tem uma característica peculiar ser composta pelo mesmo conjunto de notas tocadas por diferentes instrumentos em tempos diferentes (para entender melhor, vise a imagem "CanonInD_paritura.jpeg".
![alt text](https://upload.wikimedia.org/wikipedia/commons/1/16/Pachelbel-canon-colors.png)

O conjunto de notas que se repete pode ser extraido do arquivo MIDI "Canon.mid". Para extrair o arquivo em formato txt criamos o algoritmo "MidiParaMusica1TXT.hs". Neste algoritmo, a função writeMusicInTxt é definida tal que:

```
writeMusicInTxt :: String -> String -> IO ()
```

Desta forma, writeMusicInTxt recebe duas strings: a primeira é o diretorio onde se encontra o midi e a segunda é o nome do arquivo txt de saída com o conjunto de notas base da música. Nesta função, como está sendo usado um MIDI, para passá-lo para uma string e gravá-lo em um arquivo de texto, retiramos com o operador <$> o IO e com a função removeEither o Either (como explicado anteriormente). Assim, ao final da execução deste algoritmo, obtivemos um arquivo txt com o conjunto de notas base da música Canon in D.

No arquivo "textoMusica.hs" criamos a função musicaPrincipal que retorna o texto extraido do MIDI.

Por fim, no arquivo "Canon.hs" temos 5 partes importantes para a reprodução da música:

* principalSolo:

  O arquivo MIDI que foi extraido para txt apresentava resíduos nas extremidades do texto de outras notas que não pertence ao conjunto base de notas da música. Portanto, principalSolo remove este resíduo com a função remove e com a função retro. Além disso, também desacelera a música para que o tempo combine com as outras notas base.
  
* acompanhamentoSemRepeticao:

  Em acompanhamentoSemRepeticao escrevemos as 8 notas (apresentadas como Bass na imagem "CanonInD_partitura.jpeg"). A essas notas aplicamos o intrumento "VoiceOohs" e as passamos para o tipo Music1 com a função toMusic1 para ser compatível a música principal extraida do MIDI. Esta parte também foi desacelerada em 1/3 deu seu tempo.

* acompanhamentoCompleto:

  Em acompanhamentoCompleto, armazenamos 15 vezes a composição de acompanhamentoSemRepetição para representar o bass da música.

* adicionaPausas

```
adicionaPausas :: Music1 -> Int -> [Music1]
```
  Esta função pode ser considerada mais importante do algoritmo por ser quem monta a defasagem dos instrumentos. Esta função recebe um tipo música e um inteiro que representa o numero de vezes que as pausas serão adicionadas. A cada chama recursiva, a função concatena em um vetor duas pausas concatenadas com a música que recebe (pausa :+: pausa :+: m). O número n representa o número de instrumentos que tocam além da base. No caso do nosso exemplo, este número é 3 pois estamos tomando como base três violinos. Vale ressaltar que a pausa tem o valor rest 3.

* principalCompleta

  Em principalCompleta, adicionaPausas é acionada com a música principalSolo e com o inteiro 3 (representando os três violinos). Como o retorno de principalSolo é um vetor de músicas, usamos a função chord para concatenar as músicas com o operador :=: entre elas.


Assim, canonInD é a reprodução paralela de acompanhamentoCompleto (bass) e principalCompleta (violinos). Ao compilar o arquivo, com ```play canonInD``` é possível ouvir a reprodução da música completa.

