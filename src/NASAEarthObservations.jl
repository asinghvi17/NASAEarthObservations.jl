module NASAEarthObservations

using Glob

using Pkg.Artifacts

const rooturl = "neo.sci.gsfc.nasa.gov"

function _download_files(root, intermediate, target; dir = mktempdir())

    imgpath = "$root/$intermediate/$target"

    cd(dir) do
        run(```
            wget
                --no-parent
                --no-directories
                --no-verbose
                --reject="index.html*"
                --execute robots=off
                --include $intermediate/$target
                -r
                https://$imgpath
            ```
            )
    end
    return dir
end

download_files(dirname; root = rooturl) = _download_files(root, "archive", dirname)

"""
    observations(path)

Downloads (if necessary) and stores the data found at the path given, relative
to [`$rooturl`]($rooturl).

This method downloads the observations and then stores them as an artifact,
so that redownloading becomes unneccessary.
"""
function observations(path)

    if startswith(path, "/")
        @error "Path cannot start with `/`!" path
    elseif startswith(path, "archives")
        @error "Please give the path after archive!" path
    end

    mutable_artifacts_toml = joinpath(dirname(@__DIR__), "MutableArtifacts.toml")

    dir_name = endswith("/", path) ? path[1:end-1] : path

    dir_hash = artifact_hash(dir_name, mutable_artifacts_toml)

    if dir_hash === nothing

        dir_hash = create_artifact() do dir
            cd(dir) do
                _download_files(rooturl, "archive", path; dir = dir)
            end
        end

        bind_artifact!(
            mutable_artifacts_toml,
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
