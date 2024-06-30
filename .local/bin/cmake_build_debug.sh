#/bin/bash
mkdir -p $1/build
cd $1/build
cmake .. -DCMAKE_BUILD_TYPE=Debug
cmake --build . --config Debug
