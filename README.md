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

Para a utilização do pacote **CalPin** primeiramente é necessário instalr. Para isso o usuário pode optar por dois diferentes métodos de instalação. Sendo eles por meio dos comandos **using Pkg** e **Pkg.add(url="https://github.com/renilsonlisboa/CalPin.jl")** inseridos diretamente no terminal do Julia.

```julia
using Pkg
Pkg.add(url="https://github.com/renilsonlisboa/CalPin.jl")
```

Também é possível a instalação do pacote por meio do **modo de gerenciamento de pacotes**, para isso basta apenas utilizar o comando **] add https://github.com/renilsonlisboa/CalPin.jl**

```julia
] add https://github.com/renilsonlisboa/CalPin.jl
```

## Inicio

Após a conclusão da instalação do pacote, o usuário deverá iniciar o mesmo através dos comandos **using CalPin** e **RunApp()**
```julia
using CalPin
RunApp()
