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

