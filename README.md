# CalPin

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://renilsonlisboa.github.io/CalPin.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://renilsonlisboa.github.io/CalPin.jl/dev/)
[![Build Status](https://github.com/renilsonlisboa/CalPin.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/renilsonlisboa/CalPin.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/renilsonlisboa/CalPin.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/renilsonlisboa/CalPin.jl)

O pacote **CalPin** é uma ferramenta em Julia para realizar cálculos relacionados à altura e volume de árvores da espécie Pinus taeda.

## Opções de Uso

### Altura
Para calcular a altura, você pode utilizar as seguintes opções:

- *Pinus maximinoi*
- *Pinus taeda*

### Volume
Para calcular o volume, as opções disponíveis são:

- *Pinus caribaea hondurensis*
- *Pinus taeda*

## Instalação

O pacote **CalPin** pode ser adicionar de duas diferentes formas podendo-se optar por:

```julia
using Pkg
Pkg.add(url="https://github.com/renilsonlisboa/CalPin.jl")
```

Ou então pelo método integrado do Julia via ]

```julia
] add https://github.com/renilsonlisboa/CalPin.jl
```

## Inicio

Após instalado o pacote **CalPin** o usuário poderá iniciar o pacote através dos comandos abaixo

```julia
using CalPin
RunApp()
