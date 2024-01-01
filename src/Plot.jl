module Plot

export init_backend,  plot_result

    function init_backend(width::Float64, height::Float64)
    
        if width < 5 || height < 5
    
            return

        end

        return

    end

    function plot_result(d, plt)
        if plt !== nothing
            display(d, plt)
        else
            
        end

        return

    end

end