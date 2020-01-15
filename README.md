# NASAEarthObservations

![logo](https://neo.sci.gsfc.nasa.gov/images/backgrounds/about_main.jpg)

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://asinghvi17.github.io/NASAEarthObservations.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://asinghvi17.github.io/NASAEarthObservations.jl/dev)
[![Build Status](https://gitlab.com/asinghvi17/NASAEarthObservations.jl/badges/master/build.svg)](https://gitlab.com/asinghvi17/NASAEarthObservations.jl/pipelines)

This is a simple package which allows download of data from NASA's Earth Observation program.

We reference this URL for the data, and you should examine the directory structure there to find datasets to download: https://neo.sci.gsfc.nasa.gov/archive

## Usage

The main function exported by this package is `observations(path::String)`.  Use it to download observations from folders in the NASA FTP site above.

```julia
julia> observations("blackmarble/2016/global")
2020-01-15 18:11:01 URL:https://neo.sci.gsfc.nasa.gov/archive/blackmarble/2016/global/BlackMarble_2016_01deg.jpg [779638/779638] -> "BlackMarble_2016_01deg.jpg" [1]
[...]
2020-01-15 18:11:01 URL:https://neo.sci.gsfc.nasa.gov/archive/blackmarble/2016/global/?C=N;O=D [2631/2631] -> "index.html?C=N;O=D" [1]
".julia/artifacts/8c0a387256847375b7d76bb2ba9b9193e985de46"

julia> observations("blackmarble/2016/global")
".julia/artifacts/8c0a387256847375b7d76bb2ba9b9193e985de46"
```

This package has been made possible by [NASA's Earth Observation program](https://neo.sci.gsfc.nasa.gov/)
