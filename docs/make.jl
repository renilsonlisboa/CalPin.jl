using CalPin
using Documenter

DocMeta.setdocmeta!(CalPin, :DocTestSetup, :(using CalPin); recursive=true)

makedocs(;
    modules=[CalPin],
    authors="Renilson Lisboa Júnior <renilsonlisboajunior@gmail.com> and contributors",
    repo="https://github.com/renilsonlisboa/CalPin.jl/blob/{commit}{path}#{line}",
    sitename="CalPin.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://renilsonlisboa.github.io/CalPin.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/renilsonlisboa/CalPin.jl",
    devbranch="main",
)
