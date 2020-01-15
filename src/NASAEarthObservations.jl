module NASAEarthObservations

using Glob

using Pkg.Artifacts

const rooturl = "neo.sci.gsfc.nasa.gov/archive/"

function _download_files(imgpath)
    dir = mktempdir()
    cd(dir) do
        run(`wget --no-parent -nd -nv -r https://$imgpath`)
        rm.(readdir(glob"index.html*")) # remove all non image files
        rm("robots.txt")
    end
    return dir
end

download_files(dirname; root = rooturl) = _download_files(root*dirname)

function observations(path)

    if startswith(path, "/")
        @error "Path cannot start with '/'!" path
    elseif startswith(path, "archives")
        @error "Please give the path after archive!" path
    end

    mutable_artifacts_toml = joinpath(dirname(@__DIR__), "MutableArtifacts.toml")

    dir_name = endswith("/", path) ? path[1:end-1] : path

    dir_hash = artifact_hash(dir_name, mutable_artifacts_toml)

    if dir_hash === nothing

        dir_hash = create_artifact() do dir
            cd(dir) do
                pth = download_files(path)
                for file in joinpath.(pth, readdir(pth))
                    cp(file, basename(file))
                end
            end
        end

        bind_artifact!(mutable_artifacts_toml,
            dir_name,
            dir_hash;
            force=true
            )

    end

    return artifact_path(dir_hash)

end

export observations

function __init__()
    touch(joinpath(dirname(@__DIR__), "MutableArtifacts.toml"))
end

end # module
