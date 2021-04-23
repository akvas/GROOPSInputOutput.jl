using CxxWrap
using BinDeps

jlcxx_dir = CxxWrap.prefix_path()
jlcxx_include = joinpath(jlcxx_dir, "include")
jlcxx_module = joinpath(jlcxx_dir, "lib", "cmake")

genopt = "Unix Makefiles"

build_type = get(ENV, "CXXWRAP_BUILD_TYPE", "Release")
groops_dir = get(ENV, "GROOPS_SOURCE_DIR", joinpath(homedir(), "groops", "source"))

makeopts = ["--", "-j", "$(Sys.CPU_THREADS+2)"]

prefix = "."

groopsio_steps = @build_steps begin
	`cmake -G "$genopt" -DCMAKE_INSTALL_PREFIX="$prefix" -DCMAKE_BUILD_TYPE="$build_type" -DCMAKE_PREFIX_PATH="$jlcxx_include;$jlcxx_module" -DGROOPS_SOURCE_DIR="$groops_dir" groopsiobase`
	`cmake --build . --config $build_type --target install $makeopts`
end

BinDeps.run(groopsio_steps)
