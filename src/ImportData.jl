module ImportData

# Importa as funções especificas de cada pacote
import QML: QString
import DataFrames: DataFrame
import CSV: CSV.read

# Exporta as funções definida neste módulo
export singlefile
    
    function singlefile(uri)
        
        # Confere se a entrada (uri) é diferente de nothing
        if uri !== nothing
            uri_s = QString(uri)
        else
            return
        end

        # Remover o prefixo "file:///"
        cleaned_path = replace(uri_s, "file:///" => "")
    
        #Converte o caminho do arquivo selecionado (.CSV) em um DataFrame
        Dados = read("$cleaned_path", DataFrame)

        #Retorna o DataFrame dos dados selecionados
        return Dados

    end

end