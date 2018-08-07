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
   * Em uma composição musical, para definir o instrumento é necessário usar a função "Modify" junto ao nome do instrumento, da seguinte forma:
  
  ```
 mySong = Modify(Instrument  nome_do_instrumento)(composição)
  ```
  * Para inverter uma música, existe a função "retro" definida por:
  
  ```
  retro :: Music a -> Music a
  ```
  Dessa forma, retro mySong toca a música mySong de trás para frente
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
  
  * Tocar a música "secondSong"
  ```
  play secondSong
  ```
  
  ## Reprodução de MIDI com Euterpea
  
