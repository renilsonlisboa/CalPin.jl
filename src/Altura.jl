module Altura

using QML, Plots, LinearAlgebra

export hpta, hpma

    function hpta(dap, h, save)

        dap = Vector{Float64}(Meta.parse.(dap))
        h = Vector{Float64}(Meta.parse.(h))

        Bfixo=[-9.9265; 1.8984; 1.0016]
        
        D=[0.02525 0.002004 -0.01322; 0.002004 0.003499 -0.00429; -0.01322 -0.00429 0.01009]
        
        R =[0.007781]
        
        n=size(dap,1)
        
        R=diagm(repeat(R, inner = n))
        
        Z= [log.(dap)]
        
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
        
        savefig("$(save).png")

    end

    function hpma(dap, h, save)

        dap = Vector{Float64}(Meta.parse.(dap))
        h = Vector{Float64}(Meta.parse.(h))

        Bfixo=[-9.9265; 1.8984; 1.0016] 
        D=[0.02525 0.002004 -0.01322; 0.002004 0.003499 -0.00429; -0.01322 -0.00429 0.01009]
        
        R =[0.007781]        
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