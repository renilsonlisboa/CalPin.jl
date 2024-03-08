module Altura

# Importa os pacotes 
import QML: QString
import Plots: plot!, scatter, savefig
import LinearAlgebra: diagm

export hpta, hpma

    function hpta(dados, save)

        # Conversões de dados
        #Converte os dados informados de QVariant para um Vector{String}
        dados = convert.(Vector{String}, dados)

        # Converte os dados de String para Float64
        dap = Meta.parse.(dados[1])
        h = Meta.parse.(dados[2])
        
        # Confere se foi atribuido algum valor para a variavle save
        if save !== nothing
            save_s = QString(save)
        else
            return 0
        end

        # Remover o prefixo "file:///"
        cleaned_path = replace(save_s, "file:///" => "")

        # Remove o sufixo da URL (extensão caso selecionada)
        cleaned_path = split(cleaned_path, ".")[1]

        # Cálculos de calibração
        Bfixo=[-2.4286; 5.8784]
        D=[4.3734 1.2910; 1.2910 0.6303]
        R =[4.6233]
        n=size(dap,1)
        R=diagm(repeat(R, inner = n))
        Z= log.(dap)
        Z=[ones(n) Z]
        yhat = Z*Bfixo
        RES= h.-yhat
        b=D*Z'*inv(Z*D*Z'+R)*RES
        Bhat= round.(Bfixo+b, digits = 4)
        x0= 5:0.001:45
        xGrid = [ones(size(x0,1)) x0]
        xGridt = [ones(size(x0,1)) log.(x0)]
        yestimado = xGridt*Bhat

        # Atribui os gráficos de resultados a váriavel plt
        plt = scatter(dap, h, xlabel = "Diâmetro à altura do peito (cm)", ylabel = "Altura (m)", grid_linewidth = 0, color = "green")
        plt = plot!(xGrid[:,2], yestimado, legend = false, color = "blue")

        # Salva o gráfico atribuido ao plt
        savefig("$(cleaned_path).png")

        # Apresneta o gráfico criado em plt
        display(plt)

        return [round.(b, digits = 4), Bhat]

    end

    function hpma(dados, save)

        # Conversões de dados
        #Converte os dados informados de QVariant para um Vector{String}
        dados = convert.(Vector{String}, dados)

        # Converte os dados de String para Float64
        dap = Meta.parse.(dados[1])
        h = Meta.parse.(dados[2])

        # Confere se foi atribuido algum valor para a variavle save
        if save !== nothing
            save_s = QString(save)
        else
            return 0
        end

        # Remover o prefixo "file:///"
        cleaned_path = replace(save_s, "file:///" => "")

        # Remove o sufixo da URL (extensão caso selecionada)
        cleaned_path = split(cleaned_path, ".")[1]

        Bfixo=[-2.5135; 7.2759]
        D=[23.1108 -2.2259; -2.2259 1.5952]
        R =[6.4984]     
        n=size(dap,1)       
        R=diagm(repeat(R, inner = n))        
        Z= log.(dap)       
        Z=[ones(n) Z]     
        yhat = Z*Bfixo        
        RES= h.-yhat        
        b=D*Z'*inv(Z*D*Z'+R)*RES        
        Bhat= round.(Bfixo+b, digits = 4)  
        x0= 5:0.001:45        
        xGrid = [ones(size(x0,1)) x0]        
        xGridt = [ones(size(x0,1)) log.(x0)]        
        yestimado = xGridt*Bhat

        plt = scatter(dap, h, xlabel = "Diâmetro à altura do peito (cm)", ylabel = "Altura (m)", grid_linewidth = 0, color = "green")
        plt = plot!(xGrid[:,2], yestimado, legend = false, color = "blue")
        
        savefig("$(cleaned_path).png")

        display(plt)

        return [round.(b, digits = 4), Bhat]
    end

end