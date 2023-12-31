module Volume

# Importa os pacotes 
import QML: QString
import Plots: plot, scatter!, savefig
import LinearAlgebra: diagm

##### Exporta as funções do módulo
export vpch, vpta

    function vpch(dap, h, v, save)

        dap = Float64(Meta.parse(dap))
        h = Float64(Meta.parse(h))
        v = Float64(Meta.parse(v))

        if save !== nothing
            save_s = QString(save)
        else
            return 0
        end

        # Remover o prefixo "file:///"
        cleaned_path = replace(save_s, "file:///" => "")

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
        Bhat=Bfixo+b
        x0= 5:0.001:45
        xGrid = [ones(size(x0,1)) x0]
        xGridt = [ones(size(x0,1)) log.(x0)]
        yestimado = xGridt*Bhat
        yestimado = exp.(yestimado)

        # Gera o gráfico do ajusto
        plt = plot(xGrid[:,2], yestimado, legend = false, color = "blue", show = false)
        plt = scatter!([x = dap for x in 1:3], [y = v for y in 1:3], show = false)

        savefig("$(cleaned_path).png")

        return [Bfixo, Bhat, plt] 

    end

    function vpta(dados, save)

        dados = convert.(Vector{String}, dados)

        dap = Meta.parse.(dados[1])
        h = Meta.parse.(dados[2])
        v = Meta.parse.(dados[3])
        
        if save !== nothing
            save_s = QString(save)
        else
            return 0
        end

        # Remover o prefixo "file:///"
        cleaned_path = replace(save_s, "file:///" => "")

    #a
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
        Bhat=Bfixo+b
        x0= 5:0.001:45
        xGrid = [ones(size(x0,1)) x0]
        xGridt = [ones(size(x0,1)) log.(x0)]
        yestimado = xGridt.*Bhat

        plt = scatter(xGrid[:,2], yestimado, xlabel = "Diâmetro à altura do peito (cm)", ylabel = "Altura (m)", grid_linewidth = 0, color = "green", legend = false)
        plt = plot!(dap, h)
        
        savefig("$(cleaned_path).png")

        return [Bfixo, Bhat, plt]

    end

end