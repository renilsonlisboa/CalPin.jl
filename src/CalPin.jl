module CalPin

# Inclui os módulos auxiliares no projeto
include(joinpath(@__DIR__, "src/Altura.jl"))
include(joinpath(@__DIR__, "src/Volume.jl"))

# Importa as funções utilizadas
import QML: QString, @qmlfunction, loadqml, exec

export RunApp

    # Função de calibração da altura do Pinus maximinoi
    function hpma(dados, save)
        Altura.hpma(dados, save)
    end
        
    # Função de calibração do altura do Pinus taeda
    function hpta(dados, save)
        Altura.hpta(dados, save)
    end

    # Função de calibração do Volume do Pinus caribaea hondurensis
    function vpch(dap, h, v, save)
        Volume.vpch(dap, h, v, save)
    end
    
    # Função de calibração do Volume do Pinus caribaea hondurensis
    function vpta(dados, save)
        Volume.vpta(dados, save)
    end

    # Define a função de inicialização do app
    function RunApp()

        # Exporta as funções do Julia para o QML(JavaScript)
        @qmlfunction hpma hpta vpch vpta 

        # Localiza o diretório padrão onde o pacote foi instalado
        current_directory = dirname(@__FILE__)

        # Carrega o arquivo .qml presente no diretório do pacote
        loadqml(joinpath(current_directory, "src/qml", "main.qml"))

        # Inicializa o arquivo .qml
        exec()
    end
end