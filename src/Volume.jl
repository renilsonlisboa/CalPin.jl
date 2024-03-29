module Volume

# Importa os pacotes 
import QML: QString
import Plots: scatter!, scatter, plot, savefig
import LinearAlgebra: diagm
import DataFrames: DataFrame
import Printf: @printf

##### Exporta as funções do módulo
export vpch, vpta

    # Define a função para o cálculo do Volume do Pinus caribeae hondurensis
    function vpch(dap, h, v, save)

        # Converter as entradas de QVariant para Float64
        dap = Float64(Meta.parse(dap))
        h = Float64(Meta.parse(h))
        v = Float64(Meta.parse(v))

        # Confere se o URL para salvar o resultado é diferente de nulo
        if save !== nothing
            save_s = QString(save)
        else
            return 0
        end

        # Remover o prefixo "file:///"
        cleaned_path = replace(save_s, "file:///" => "")

        # Remove o sufixo da URL (extensão caso selecionada)
        cleaned_path = split(cleaned_path, ".")[1]

        # Cálculos das estimativas
        Bfixo=[-9.7756; 0.9430]
        D=[0.09528 -0.01078; -0.01078 0.001221]
        R =[0.00706]
        n=size(dap,1)
        R=diagm(repeat(R, inner = n))
        Z= log.((dap.^2) .* h)
        Z=[ones(n) Z]
        yhat = Z*Bfixo
        RES=log.(v).-yhat
        b=D*Z'*inv(Z*D*Z'+R)*RES
        Bhat= round.(Bfixo+b, digits = 7)
        auxDap = [8.9,10.2,8.9,11.8,15.6,14.6,13.7,13.7,19.4,16.9,16.6,19.7,21.3,22.3,22.9,22.3,23.9,23.9,24.8,25.5,11.8,9.5,15.3,12.7,19.1,17.8,22.3,23.6,27.7,26.7,11.1,10.5,15.9,14.6,18.1,16.2,21.6,20.7,23.9,25.1,11.1,10.2,11.8,11.5,14.6,15.9,14.00,15.3,16.6,18.1,19.1,17.5,22.9,21.3,22.3,23.6,25.5,26.4,25.8,24.8,11.1,8.2,14.3,18.6,18.1,20.8,23.00,22.6,25.6,28.1,12.9,11.8,17.7,16.3,14.7,25.3,24.2,21.5,25.6,12.2,18.9,21.5,27.1,12.7,11.8,17.5,20.5,16.9,22.8,22.9,22.1,29.3,31.5,13.1,16.9,26.4,23.2,29.00,31.2,16.9,13.5,22.4,18.7,20.1,27.1,25.5,26.1,37.4,32.3,17.5,12.8,18.00,22.1,20.9,27.9,24.8,25.9,31.4,36.1,13.3,13.1,14.8,18.9,20.6,23.1,26.6,21.5,27.8,31.5,12.7,12.9,19.00,16.7,18.00,26.2,23.3,22.00,31.5,29.00,8.00,11.1,10.2,12.7,14.3,15.3,19.4,17.2,16.6,20.4,22.00,22.9,24.2,25.8,25.5,11.5,9.5,10.2,15.9,15.6,12.7,20.1,17.2,19.1,21.00,21.6,21.3,23.9,24.2,22.9,10.2,10.8,14.00,14.6,16.6,18.5,21.00,22.6,26.4,28.3,11.5,8.3,15.9,15.3,17.2,19.1,23.2,22.3,26.4,27.7,11.8,14.6,19.4,20.8,26.7,10.1,15.7,23.2,19.6,26.6]
        auxht = [9.7,9.6,10.2,11.4,11.6,11.2,13.5,12.6,12.5,11.7,14.00,11.9,14.00,13.4,14.9,13.5,13.2,13.4,12.8,13.1,10.9,8.4,11.1,11.4,12.2,12.9,13.2,14.7,14.1,14.9,9.3,10.1,13.7,12.7,13.5,13.2,13.9,13.9,12.8,14.9,11.9,9.4,10.9,10.1,11.2,12.5,10.6,11.2,12.7,12.6,12.5,12.00,13.9,14.7,14.3,13.8,14.00,15.3,15.3,15.5,10.8,8.00,12.7,13.8,14.6,14.6,16.6,15.9,14.3,15.9,13.2,11.7,14.5,13.9,12.4,15.5,13.7,15.4,13.9,10.4,13.00,15.8,16.3,17.00,13.6,18.00,17.6,16.5,19.5,19.00,19.3,20.00,20.9,12.00,16.9,15.9,18.8,18.9,21.5,16.2,13.6,17.3,17.7,17.00,17.00,19.4,17.5,19.00,19.1,15.6,11.7,17.1,15.6,17.8,16.6,19.5,16.2,19.00,20.4,16.00,14.00,15.9,18.4,18.2,18.6,20.00,17.00,19.4,19.5,14.3,14.00,19.00,17.3,17.3,19.5,19.5,18.3,19.2,20.6,7.4,12.8,10.1,12.1,12.9,10.9,15.5,16.00,13.3,15.6,16.1,14.8,15.6,16.8,16.5,9.5,8.2,9.4,10.2,10.00,10.00,12.5,11.7,11.7,11.4,13.00,11.5,13.00,11.00,14.2,9.4,10.7,12.6,12.6,14.5,13.8,13.8,16.5,15.7,14.6,10.3,7.2,14.5,11.5,12.5,14.3,14.9,14.2,14.6,14.7,8.3,8.6,14.7,13.8,13.2,8.00,10.00,11.6,11.1,13.4]
        orderData = sort(DataFrame([auxDap auxht], :auto), :x1) 
        x0 = (orderData.x1.^2).*orderData.x2
        xGrid = [ones(size(x0,1)) x0]
        xGridt = [ones(size(x0,1)) log.(x0)]
        yestimado = xGridt*Bhat
        yestimado = exp.(yestimado)

        # Gera o gráfico do ajuste
        plt = plot(x0, yestimado, legend = false, color = "blue")
        plt = scatter!([x = ((dap^2)*h) for x in 1:3], [y = v for y in 1:3], xlabel = "d²h", ylabel = "Volume (m³)", grid_linewidth = 0, color = "green", ms = 6, xformatter=x -> replace(string(Int64.(x)), r"(\d)(?=(\d{3})+(?=\D|$))" => s"\1."))
        
        # Salva a figura gerada
        savefig("$(cleaned_path).png")

        #APresenta a figura gerada
        display(plt)

        # Resultados passados para o arquivo .QML
        return [Bfixo, Bhat] 

    end

    function vpta(dados, save)

        # Converte o vetor de dados de QVariat para um Vetor de Strings do Julia
        dados = convert.(Vector{String}, dados)

        # Converte os dados para Float64
        dap = Meta.parse.(dados[1])
        h = Meta.parse.(dados[2])
        v = Meta.parse.(dados[3])
        
        # Confere se o URL para salvar o resultado é diferente de nulo
        if save !== nothing
            save_s = QString(save)
        else
            return 0
        end

        # Remover o prefixo "file:///"
        cleaned_path = replace(save_s, "file:///" => "")

        # Remove o sufixo da URL (extensão caso selecionada)
        cleaned_path = split(cleaned_path, ".")[1]

        dap = [15.3, 22.0, 26.7, 28.3, 35.7, 20.0, 17.0]
        h = [16.1, 15.0, 17.4, 16.6, 18.1, 14.5, 15.5] 
        v = [0.151, 0.294, 0.372, 0.317, 0.736, 0.182,0.152]

        # Cálculos das estimativas
        Bfixo=[-9.9265; 1.8984; 1.0016]
        D=[0.02525 0.002004 -0.01322; 0.002004 0.003499 -0.00429; -0.01322 -0.00429 0.01009]
        R =[0.007781]
        n=size(dap,1)
        R=diagm(repeat(R, inner = n))
        Z= [log.(dap) log.(h)]
        Z=[ones(n) Z]
        yhat = Z*Bfixo
        RES= v.-yhat
        b=D*Z'*inv(Z*D*Z'+R)*RES
        Bhat= round.(Bfixo+b, digits = 7)
        auxDap = [13.7, 13.7, 14.6, 15.3, 15.6, 16.2, 16.9, 16.9, 18.1, 19.4, 19.7, 19.7, 21.3, 21.6, 22, 22.3, 23.2, 23.6, 23.9, 24.2, 25.5, 26.7, 27.4, 27.7, 28.3, 29, 29.3, 29.3, 29.3, 30.2, 31.2, 32.1, 33.1, 33.1, 33.4, 34.4, 34.4, 35.3, 35.3, 35.7, 25.5, 34.5, 32.5, 26, 17.7, 16.5, 21, 28.5, 24, 32, 33.5, 29.2, 21.5, 23.5, 18.3, 33, 27.8, 37.5, 35, 16.5, 25.3, 26, 27, 33, 23.4, 28.7, 13.7, 24.3, 20, 26.2, 26.3, 27.5, 27.5, 13.4, 11.1, 15, 20, 23.4, 18.8, 16.7, 20.1, 25.8, 21.9, 23.5, 13.8, 12.8, 9.9, 13, 16.7, 20.4, 21, 25.8, 13.2, 15.8, 27, 14.5, 22.4, 28, 17, 22.4, 29.6, 28, 23.5, 23.6, 18, 16.5, 26.5, 21.7, 12.8, 14.5, 24.8, 28.5, 27.2, 17.8, 22.5, 14.5, 15, 25.5, 16, 22.5, 23.2, 28, 30.6, 35, 38.2, 43.6, 46.5, 15, 15.3, 15.9, 18.8, 21, 20.7, 25.8, 27.7, 29.9, 30.9, 11, 29.5, 22, 14, 29, 15.5, 24.5, 16, 26, 14, 32, 34, 22, 7.8, 17, 17.5, 21.5, 9, 30, 12, 24.5, 23, 13.5, 11, 17.5, 20.7, 25.2, 29, 32.5, 37.6, 41.4, 13.7, 15, 16.6, 19.7, 22.9, 23.9, 25.5, 27.1, 11.1, 11.8, 12.7, 14.3, 17.2, 19.1, 22.9, 23.2, 24.5, 26.1, 12.7, 15, 17.2, 18.5, 22.9, 23.6, 26.1, 28, 31.8, 26.1, 22.6, 28.6, 30.6, 36.3, 33.1, 39.2, 39.8, 42, 41.7, 24.5, 26.1, 28.3, 28.3, 34.7, 32.8, 38.5, 37.6, 41.7, 42.3, 24.5, 26.4, 29, 29.3, 32.1, 34.4, 40.7, 37.9, 42, 43, 23.2, 26.1, 31.5, 28.6, 35, 36.3, 40.4, 37.9, 41.7, 44.2, 14, 15.6, 20.1, 19.4, 24.5, 27.7, 31.2, 29, 34.1, 36, 15.6, 15.3, 21.6, 20.7, 24.5, 28.3, 31.8, 32.8, 36, 37.9, 15.3, 15.9, 21.3, 20.1, 24.2, 25.5, 28.6, 30.6, 33.7, 36.6, 14.6, 15, 20.7, 19.1, 26.7, 24.2, 32.8, 30.6, 35, 34.1, 42.7, 18.1, 30.9, 35.7, 34.7, 23.9, 29, 41.4, 19.7, 10.8, 29.6, 23.9, 26.4, 17.8, 13.4, 8.3, 22, 14, 26.7, 18.5, 31.5, 11.8, 19.1, 8.9, 13.4, 29.3, 17.5, 23.9, 30.6, 6.1, 15.3, 32.8, 20.7]
        auxht = [14.1, 12.3, 13.6, 16.1, 13.62, 13.6, 13.35, 15.1, 15.1, 15.7, 16.4, 16.4, 16.23, 14.03, 15, 15.62, 17.2, 17.1, 16.28, 17.2, 15.9, 17.4, 15.2, 18.6, 16.6, 15.1, 17.5, 17.4, 18.3, 16.3, 16.9, 17.1, 17.22, 16.9, 17.3, 18.3, 17.6, 18.1, 18.9, 18.1, 20.3, 21.8, 20.8, 20.5, 18.4, 18.9, 19.5, 21, 19.8, 22.5, 21.2, 21.1, 17.2, 16.9, 16, 18.5, 18.1, 21.5, 19.2, 15.8, 17.2, 18.4, 16.2, 17.3, 14.3, 14.9, 11.5, 14.2, 14.5, 14.4, 14, 13.8, 13.3, 12.4, 10.1, 13.2, 13.4, 13, 12.1, 12, 13, 13.8, 13.4, 13.1, 10.3, 12, 9.5, 11.3, 12.5, 13.4, 17.8, 17.8, 14.4, 16.48, 19.2, 14, 15.6, 17.8, 15.5, 18.2, 18.3, 16.5, 15.88, 16.7, 16.5, 15.6, 18.5, 14.6, 9.1, 9.6, 17.4, 18.3, 18.3, 16.4, 16.8, 14.2, 14.3, 17.3, 16.1, 17.6, 19.9, 20.8, 23.2, 23.9, 22.1, 24.9, 24.2, 10.8, 13, 13.2, 15.3, 14.4, 15, 15.3, 16.7, 17.6, 16.4, 15, 16.8, 16.4, 12.3, 15.9, 14.8, 16.7, 13.1, 17.2, 12.6, 16.3, 18.9, 14.6, 11.6, 12.4, 14.3, 14.6, 10.7, 15.1, 9.9, 14.7, 14.4, 10.4, 11.8, 17.5, 17, 22.3, 20.8, 21.9, 21.7, 22.2, 12.1, 13.2, 13.4, 14.4, 15.5, 16.3, 15.3, 15.6, 11.42, 11.3, 12.77, 12.55, 13.02, 13.4, 14.5, 14.8, 15.36, 14.87, 10.9, 12.03, 11.16, 13.45, 14.1, 13.76, 14.1, 14.33, 14.5, 24, 22.1, 22.8, 21.6, 23.2, 22.4, 24.2, 24.4, 23.5, 23.4, 21.6, 22.5, 23.87, 24.04, 23.38, 23.8, 24.83, 25.7, 25.5, 24.4, 24.8, 24.8, 24.58, 24.2, 24.5, 25.6, 25, 25.5, 25.87, 27.3, 22.2, 23.2, 22.7, 24.1, 22, 24, 23, 24.2, 24.6, 23.2, 18.6, 17.3, 19.1, 17, 20.7, 19.4, 20.6, 19.9, 22.3, 21.7, 16.4, 18, 17.7, 17.1, 17.2, 17, 17.7, 17.9, 19.6, 18.5, 16.3, 16.8, 17.1, 15.4, 17, 16.7, 17.4, 17, 17.6, 18.7, 17.3, 17.9, 18.6, 17, 16.6, 16.4, 18.4, 17.7, 18, 18.1, 24.7, 21.2, 24.9, 24.5, 24.9, 23.2, 25.8, 23.6, 13.1, 10, 13.5, 12.6, 15.1, 11.8, 12.6, 6.7, 11.8, 10.4, 13.2, 12.3, 14.7, 9.7, 11.9, 7.1, 11.2, 15.4, 12.6, 12.7, 15.2, 7.2, 10.5, 15.4, 12.9]
        xGridt = [ones(size(auxDap,1)) log.(auxht) log.(auxDap)]
        yestimado = (exp.(xGridt*Bhat))
        orderData = sort(DataFrame([auxDap auxht yestimado ((auxDap.^2).*auxht)], :auto), :x4) 

        # Gera o gráfico do ajusto
        plt = scatter(orderData.x4, orderData.x3, xlabel = "d²h", label = (false))
        plt = scatter!(((dap.^2).*h), v, ylabel = "Volume (m³)", grid_linewidth = 0, color = "green", legend = false, ms = 6, xformatter=x -> replace(string(Int64.(x)), r"(\d)(?=(\d{3})+(?=\D|$))" => s"\1.")) 
        
        # Salva o resultado gerad
        savefig("$(cleaned_path).png")
        
        # Apresente o resultado gerado
        display(plt)

        # Retorna o resultado para o QML
        return [Bfixo, Bhat]

    end

end