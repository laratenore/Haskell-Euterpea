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

  Com a biblioteca Euterpea é possível escrever músicas baseadas em notas simples. Para trabalhar com este tipo de composição é necessário ter conhecimento dos três conceitos básicas principais explicados abaixo:

* Tratando-se de teoria musical, uma nota é composta por um Pitch (tom ou oitava) e por uma duration (duração). Uma nota na biblioteca é do tipo Music Pitch.

* Na biblioteca Euterpea existem duas funções principais: note e rest.

```
note :: Dur → Pitch → Music Pitch
rest :: Dur → Music Pitch
```

  Assim, note d p pode ser lido como uma nota de duração d e oitava p. Da mesma forma, rest d é uma pausa de duração d.

* Para composição de músicas, combinar notas usa-se os seguintes operadores:
 ``` 
 (:+:) :: Music Pitch → Music Pitch → Music Pitch
 (:=:) :: Music Pitch → Music Pitch → Music Pitch
 ```
 Assim, n1 :+: n2 é uma música que toca primeiro a nota n1 seguido da nota n2. Por outro lado, n1 :=: n2 é uma música que toca as notas n1 e n2 ao mesmo tempo, ou seja, em paralelo.
 
Vale ressaltar que as notas são convertidas da seguinte forma:

Dó → c  /  Ré → d  /  Mi → e  /  Fá → f  /  Sol → g  /  Lá → a  /  Si → b

  Por fim, a biblioteca Euterpea usa como instrumento default o piano, mas é possível escolher um instrumento. É possível obter a lista de instrumentos possíveis pelo GHCI usando o seguinte comando:

```
:i InstrumentName
 ```
 ### Funções
 
   * Para definir o instrumento é necessário usar a função "Modify" junto ao nome do instrumento, da seguinte forma:
 ```
 Modify :: Control -> Music a -> Music a
 ```
 Na definição da função, Modify recebe uma entrada do tipo Control que no caso da biblioteca Euterpea é a Instrument InstrumentName
  ```
 mySong = Modify(Instrument  nome_do_instrumento)(composição)
  ```
  É possível definir o instrumento no algoritmo diretamente na composição ou ao compilar a composição, como veremos em exemplos abaixo.
  
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
 
 * Para tocar músicas diferentes em paralelo
 
 ```
 chord   :: [Music a] -> Music a
 ```
  
A função chord recebe uma lista de composições e reproduz as composições em paralelo como saída. Assim, chord [m1,m2] reproduz a composição m1 :=: m2.

* Para inverter a ordem das notas por tons

```
invert :: Music Pitch -> Music Pitch
```
A função invert é usada para inverter a ordem das notas de forma que Dó continua como Dó, Ré passa a ser interpretado como Si, Mi passa a ser intepretado como Lá, e assim por diante, ou seja, inverte a ordem original das notas. Essa inversão leva em consideração o número de tons entre duas notas. Dessa forma, se invert receber apenas uma nota, retornará está mesma nota, porém, se invert recebe duas notas que possuem x tons entre elas, a segunda nota é convertida para a nota que se encontra a x tons anteriores a primeira nota, usada como referência pela função.

 ## Exemplo e compilação
  Tomando como exemplo o código do arquivo "teste.hs", a compilação e teste da composição "secondSong" pode ser dada da seguinte forma:
  
  * Importando o arquivo no GHCI:
  ```
  ghci teste.hs
  ```
  ou 
  ```
  ghci 
  :l teste.hs
  ```
  
  * Tocar a música "secondSong":
  ```
  play mySong
  ```
  
  * Tocar música com outro instrumento (funciona apenas se o instrumento não está já definido na composição):
  
  ```
  (play . Modify(Instrument Ocarina)) mySong
  ```
  * Tocar a música de trás para frente:
  ```
  (play . retro) mySong
  ```
  
  * Acelerar ou desacelerar uma música, respectivamente:
  ```
  (play . tempo (2) ) mySong
  ```
  ```
  (play . tempo (1/2) ) mySong
  ```
  
  * Tocar uma lista de composições em paralelo
  ```
  play  chord [mySong1, mySong2] 
  ```
  
  * Tocar uma música com as notas invertidas de acordo com os tons:
  
  ```
  (play . invert) mySong
  ```
  
  ## Usando arquivos MIDI com Euterpea
  
  Além de composições, a biblioteca Euterpea pode ser usada para leitura, reprodução e criação de arquivos MIDI. Arquivos MIDI são arquivos no formato Musical Instrument Digital Interface, ou seja, não são arquivos de áudio, mas sim um protocolo de comunicação entre um instrumento e um módulo ou um hardware que não contem dados de audio, e sim instruções de como produzi-lo. 
  
 Usando o arquivo midiTest.hs é possível reproduzir um arquivo MIDI no GHCI usando os seguintes comandos:
 
 ```
 ghci midiTest.hs
 ```
 ```
playFromPath
 ```
 O primeiro comando é usado para que o ghci leia o arquivo que você usará para reproduzir o MIDI. O segundo comando é para enviar para o algoritmo o MIDI que você quer que seja reproduzido. Neste comando, playFilePath é o nome de uma função do algoritmos que solicita o caminho do diretório onde se encontra o seu arquivo MIDI seguido pelo nome do arquivo MIDI.
 
  Antes de ser reproduzido, o arquivo MIDI precisa ser tratado devido a forma como entra no programa. Por ser uma entrada externa ao programa, o arquivo entra com o tipo IO. Além disso, o arquivo de entrada pode ser tanto um MIDI quanto uma string (arquivo de texto), então o arquivo também entra com o tipo Either de forma que Right representa o arquivo MIDI e Left uma string (txt). No segundo caso, o programa retorna um erro pois a inteção é reproduzir apenas caso Right. 
  
  Para que o programa consiga reproduzir o arquivo, a função playFromMidi é usada para retirar o IO e o Either. Esta função é defininda como:
  ```
  playFromMidi :: IO (Either String Midi) -> IO ()
  ```
  PlayFromMidi retorna apenas a saída em formato de som (IO) que ocorre devido a combinação da função play com a função fromMidi aplicada no arquivo de entrada. A função fromMidi transforma o arquivo de entrada para um texto no formato de composição, com notas, intervalos, rests e instrumentos, ou seja, no formato Music1 que pode ser reproduzido com play, como vimos na sessão anterior.

 
