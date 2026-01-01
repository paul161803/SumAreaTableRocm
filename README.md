# SumAreaTableRocm
Calculate sum area table of 2D matrix/image

# Environment
* Ubuntu 24.04.3 LTS
* cmake version 3.28.3
* rocm 7.1.1

# Build
* ```cd SumAreaTable```
* ```cmake -S . -B build -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=Debug/Release```
* ```cd build```
* ```cmake --build .```

# Reference
[https://ieeexplore.ieee.org/document/8425490/citations#citations](https://www.cs.hiroshima-u.ac.jp/cs/_media/sat_apdcm.pdf)
