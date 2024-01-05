module Altura

using QML, Plots, LinearAlgebra

export hpta, hpma

    function hpta(dados, save)

        dados = convert.(Vector{String}, dados)

        dap = Meta.parse.(dados[1])
        h = Meta.parse.(dados[2])
        
        if save !== nothing
            save_s = QString(save)
        else
            return 0
        end

        # Remover o prefixo "file:///"
        cleaned_path = replace(save_s, "file:///" => "")

    #a
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
        Bhat=Bfixo+b
        x0= 5:0.001:45
        xGrid = [ones(size(x0,1)) x0]
        xGridt = [ones(size(x0,1)) log.(x0)]
        yestimado = xGridt*Bhat

        plt = scatter(dap, h, xlabel = "Diâmetro à altura do peito (cm)", ylabel = "Altura (m)", grid_linewidth = 0, color = "green")
        

        savefig("$(cleaned_path).png")

        return [Bfixo, Bhat]

    end

    function hpma(dados, save)

        dados = convert.(Vector{String}, dados)

        dap = Meta.parse.(dados[1])
        h = Meta.parse.(dados[2])
        
        if save !== nothing
            save_s = QString(save)
        else
            return 0
        end

        # Remover o prefixo "file:///"
        cleaned_path = replace(save_s, "file:///" => "")

        Bfixo=[-2.4286; 5.8784]
        D=[4.3734 1.2910; 1.2910 0.6303]
        R =[4.6233]     
        n=size(dap,1)        
        R=diagm(repeat(R, inner = n))        
        Z= [log.(dap)]        
        Z=[ones(n) Z]        
        yhat = Z*Bfixo        
        RES= h.-yhat        
        b=D*Z'*inv(Z*D*Z'+R)*RES        
        Bhat=Bfixo+b        
        x0= 5:0.001:45        
        xGrid = [ones(size(x0,1)) x0]        
        xGridt = [ones(size(x0,1)) log.(x0)]        
        yestimado = xGridt*Bhat

        scatter(dap, h, xlabel = "Diâmetro à altura do peito (cm)", ylabel = "Altura (m)", grid_linewidth = 0, color = "green")
        plot!(xGrid[:,2], yestimado, legend = false, color = "blue")
        
        savefig("$(save).png")
        
    end

end