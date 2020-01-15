using Documenter, NASAEarthObservations

makedocs(;
    modules=[NASAEarthObservations],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/asinghvi17/NASAEarthObservations.jl/blob/{commit}{path}#L{line}",
    sitename="NASAEarthObservations.jl",
    authors="Anshul Singhvi",
    assets=String[],
)
