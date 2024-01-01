module CalPin

# Inclui os módulos auxiliares no projeto
include(joinpath(@__DIR__, "Altura.jl"))
include(joinpath(@__DIR__, "Volume.jl"))
include(joinpath(@__DIR__, "Plot.jl"))

import QML: QString, @qmlfunction, loadqml, exec

export CalcPin

    # Função de calibração da altura do Pinus maximinoi
    function hpma(d, h, save)
        Altura.hpma(d, h, save)
    end
        
    # Função de calibração do altura do Pinus taeda
    function hpta(d, h, save)
        Altura.hpta(d, h, save)
    end

    # Função de calibração do Volume do Pinus caribaea hondurensis
    function vpch(dap, h, v, save)
        Volume.vpch(dap, h, v, save)
    end
    
    # Função de calibração do Volume do Pinus caribaea hondurensis
    function vpta(d, h, v, save)
        Volume.vpta(d, h, v, save)
    end

    function init_backend(width, height)
        Plot.init_backend(width, height)
    end

    function plot_result(d, plt)
        Plot.plot_result(d, plt)
    end

    # Define a função de inicialização do app
    function CalcPin()

        # Exporta as funções do Julia para o QML(JavaScript)
        @qmlfunction hpma hpta vpch vpta plot_result init_backend 

        # Localiza o diretório padrão onde o pacote foi instalado
        current_directory = dirname(@__FILE__)

        # Carrega o arquivo .qml presente no diretório do pacote
        loadqml(joinpath(current_directory, "qml", "main.qml"))

        # Inicializa o arquivo .qml
        exec()

    end

end