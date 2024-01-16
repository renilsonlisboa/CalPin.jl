module Volume

# Importa os pacotes 
import QML: QString
import Plots: plot, scatter!, savefig
import LinearAlgebra: diagm
import DataFrames: DataFrame

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
        Bhat= round.(Bfixo+b, digits = 7)
        auxDap = [8.9,10.2,8.9,11.8,15.6,14.6,13.7,13.7,19.4,16.9,16.6,19.7,21.3,22.3,22.9,22.3,23.9,23.9,24.8,25.5,11.8,9.5,15.3,12.7,19.1,17.8,22.3,23.6,27.7,26.7,11.1,10.5,15.9,14.6,18.1,16.2,21.6,20.7,23.9,25.1,11.1,10.2,11.8,11.5,14.6,15.9,14.00,15.3,16.6,18.1,19.1,17.5,22.9,21.3,22.3,23.6,25.5,26.4,25.8,24.8,11.1,8.2,14.3,18.6,18.1,20.8,23.00,22.6,25.6,28.1,12.9,11.8,17.7,16.3,14.7,25.3,24.2,21.5,25.6,12.2,18.9,21.5,27.1,12.7,11.8,17.5,20.5,16.9,22.8,22.9,22.1,29.3,31.5,13.1,16.9,26.4,23.2,29.00,31.2,16.9,13.5,22.4,18.7,20.1,27.1,25.5,26.1,37.4,32.3,17.5,12.8,18.00,22.1,20.9,27.9,24.8,25.9,31.4,36.1,13.3,13.1,14.8,18.9,20.6,23.1,26.6,21.5,27.8,31.5,12.7,12.9,19.00,16.7,18.00,26.2,23.3,22.00,31.5,29.00,8.00,11.1,10.2,12.7,14.3,15.3,19.4,17.2,16.6,20.4,22.00,22.9,24.2,25.8,25.5,11.5,9.5,10.2,15.9,15.6,12.7,20.1,17.2,19.1,21.00,21.6,21.3,23.9,24.2,22.9,10.2,10.8,14.00,14.6,16.6,18.5,21.00,22.6,26.4,28.3,11.5,8.3,15.9,15.3,17.2,19.1,23.2,22.3,26.4,27.7,11.8,14.6,19.4,20.8,26.7,10.1,15.7,23.2,19.6,26.6]
        auxht = [9.7,9.6,10.2,11.4,11.6,11.2,13.5,12.6,12.5,11.7,14.00,11.9,14.00,13.4,14.9,13.5,13.2,13.4,12.8,13.1,10.9,8.4,11.1,11.4,12.2,12.9,13.2,14.7,14.1,14.9,9.3,10.1,13.7,12.7,13.5,13.2,13.9,13.9,12.8,14.9,11.9,9.4,10.9,10.1,11.2,12.5,10.6,11.2,12.7,12.6,12.5,12.00,13.9,14.7,14.3,13.8,14.00,15.3,15.3,15.5,10.8,8.00,12.7,13.8,14.6,14.6,16.6,15.9,14.3,15.9,13.2,11.7,14.5,13.9,12.4,15.5,13.7,15.4,13.9,10.4,13.00,15.8,16.3,17.00,13.6,18.00,17.6,16.5,19.5,19.00,19.3,20.00,20.9,12.00,16.9,15.9,18.8,18.9,21.5,16.2,13.6,17.3,17.7,17.00,17.00,19.4,17.5,19.00,19.1,15.6,11.7,17.1,15.6,17.8,16.6,19.5,16.2,19.00,20.4,16.00,14.00,15.9,18.4,18.2,18.6,20.00,17.00,19.4,19.5,14.3,14.00,19.00,17.3,17.3,19.5,19.5,18.3,19.2,20.6,7.4,12.8,10.1,12.1,12.9,10.9,15.5,16.00,13.3,15.6,16.1,14.8,15.6,16.8,16.5,9.5,8.2,9.4,10.2,10.00,10.00,12.5,11.7,11.7,11.4,13.00,11.5,13.00,11.00,14.2,9.4,10.7,12.6,12.6,14.5,13.8,13.8,16.5,15.7,14.6,10.3,7.2,14.5,11.5,12.5,14.3,14.9,14.2,14.6,14.7,8.3,8.6,14.7,13.8,13.2,8.00,10.00,11.6,11.1,13.4]
        orderData = sort(DataFrame([auxDap auxht], :auto), :x1) 
        x0 = (orderData.x1.^2).*orderData.x2

        xGrid = [ones(size(x0,1)) x0]
        xGridt = [ones(size(x0,1)) log.(x0)]
        yestimado = xGridt*Bhat
        yestimado = exp.(yestimado)

        # Gera o gráfico do ajusto
        plt = plot(orderData.x1, yestimado, legend = false, color = "blue", show = false)
        plt = scatter!([x = dap for x in 1:3], [y = v for y in 1:3], show = false)

        display(plt)

        savefig("$(cleaned_path).png")

        return [Bfixo, Bhat] 

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
        Bhat= round.(Bfixo+b, digits = 7)
        x0= 5:0.001:45
        xGrid = [ones(size(x0,1)) x0]
        xGridt = [ones(size(x0,1)) log.(x0)]
        yestimado = xGridt.*Bhat

        plt = scatter(xGrid[:,2], yestimado, xlabel = "Diâmetro à altura do peito (cm)", ylabel = "Altura (m)", grid_linewidth = 0, color = "green", legend = false)
        plt = plot!(dap, h)
        
        display(plt)

        savefig("$(cleaned_path).png")

        return [Bfixo, Bhat]

    end

end