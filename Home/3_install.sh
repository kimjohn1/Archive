
# Install SCIRun
    cd ~/
	export CMAKE_PREFIX_PATH=~/lib/pngwriter:$CMAKE_PREFIX_PATH
    export LD_LIBRARY_PATH=~/lib/pngwriter/lib:$LD_LIBRARY_PATH
    export CMAKE_PREFIX_PATH=~/lib/ADIOS2:$CMAKE_PREFIX_PATH
    export LD_LIBRARY_PATH=~/lib/ADIOS2/lib:$LD_LIBRARY_PATH
    export CMAKE_PREFIX_PATH=~/lib/openPMD-api:$CMAKE_PREFIX_PATH
    export LD_LIBRARY_PATH=~/lib/openPMD-api/lib:$LD_LIBRARY_PATH
    export CMAKE_PREFIX_PATH=~/Qt/6.3.1/gcc_64/lib/cmake:$CMAKE_PREFIX_PATH

    git clone https://github.com/kimjohn1/SCIRun.git
    cd SCIRun
    git checkout dev_4
    cd bin
    cmake -DSCIRUN_QT_MIN_VERSION=6.3.1 -DQt_PATH=~/Qt/6.3.1/gcc_64 -DWITH_OSPRAY=OFF ../Superbuild
    make -j8
    cd ~/

# Load data to the directories
    cd ~/
    cp -a ~/src/picongpu/share/picongpu/examples/* ~/simulations
    cp -a ~/support/networks ~/Documents
    cp -a ~/support/sim_out ~/Documents
    cp -a ~/support/cnpy ~/src

# Compile cnpy example1
    mkdir -p ~/src/cnpy-build
    cd ~/src/cnpy-build
    cmake ~/src/cnpy
    make
    cd ~/
