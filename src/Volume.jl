module Volume

# Importa os pacotes 
using QML, Plots, LinearAlgebra

##### Exporta as funções do módulo
export vpch, vpta

    function vpch(dap, h, v, save)

        dap = Float64(Meta.parse(dap))
        h = Float64(Meta.parse(h))
        v = Float64(Meta.parse(v))

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
        plot(xGrid[:,2], yestimado, legend = false, color = "blue")

        savefig("$(save).png")

    end

    function vpta(dap, h, v, save)

        dap = Vector{Float64}(Meta.parse.(dap))
        h = Vector{Float64}(Meta.parse.(h))
        v = Vector{Float64}(Meta.parse.(v))

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
        
        yestimado = xGridt*Bhat
        
        scatter(dap, h, xlabel = "Diâmetro à altura do peito (cm)", ylabel = "Altura (m)", grid_linewidth = 0, color = "green")
        
        plot!(xGrid[:,2], yestimado, legend = false, color = "blue")
        
        savefig("$save/Altura_Calibrada.png")

    end

end