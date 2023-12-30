module CalPin

# Inclui os módulos auxiliares no projeto
include(joinpath(@__DIR__, "src/Altura.jl"))
include(joinpath(@__DIR__, "src/Volume.jl"))
include(joinpath(@__DIR__, "src/Save.jl"))
include(joinpath(@__DIR__, "src/ImportData.jl"))

import QML: QString, @qmlfunction, loadqml, exec

export CalcPin
    
    # Função para seleção de arquivo em .CSV com dados para processamento
    function singleFile(arg)
        ImportData.singlefile(arg)
    end

    # Função salvar os resultados do processamento em .XLSX
    function saveFile(Resultado, uri)
        Save.saveFile(Resultado, uri)
    end
    
    # Define a função de inicialização do app
    function CalcPin()

        # Exporta as funções do Julia para o QML(JavaScript)
        @qmlfunction singleFile saveFile

        # Localiza o diretório padrão onde o pacote foi instalado
        current_directory = dirname(@__FILE__)

        # Carrega o arquivo .qml presente no diretório do pacote
        loadqml(joinpath(current_directory, "src/qml", "main.qml"))

        # Inicializa o arquivo .qml
        exec()

    end

end