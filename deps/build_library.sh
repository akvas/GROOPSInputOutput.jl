rm -rf build
mkdir build && cd build
JLCXX_PREFIX="$(julia -e "using CxxWrap; print(CxxWrap.prefix_path())")"
JLCXX_INCLUDE_DIR=$JLCXX_PREFIX/include
JLCXX_MODULE_DIR=$JLCXX_PREFIX/lib/cmake
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH="$JLCXX_INCLUDE_DIR;$JLCXX_MODULE_DIR" -DGROOPS_SOURCE_DIR=$HOME/groops/source ..
cmake --build . --config Release
cd ..
