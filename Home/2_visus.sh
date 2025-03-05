# Set up the desktop launcher
    sudo cp support/LWFA_pt.png /usr/share/icons
    cp support/SCIRun-PT.desktop ~/Desktop
    chmod +rwx ~/Desktop/SCIRun-PT.desktop

# Install PIConGPU
# Remove any previously installed directories         #From the original dev2-picongpu.dependencies
    rm -rf ~/src/openPMD-api ~/src/openPMD-api-build ~/src/picongpu ~/src/pngwriter ~/src/pngwriter-build ~/src/ADIOS2 ~/src/ADIOS2-build
    rm -rf ~/lib/openPMD-api ~/lib/pngwriter ~/lib/ADIOS2
    rm -rf ~/scratch
    rm -rf ~/picInputs
    rm -f ~/cuda-repo-ubuntu2204-12-1-local_12.1.0-530.30.02-1_amd64.deb

     
# Create directories
    mkdir -p ~/src/openPMD-api ~/src/openPMD-api-build
    mkdir -p ~/src/pngwriter ~/src/pngwriter-build
    mkdir -p ~/src/ADIOS2 ~/src/ADIOS2-build
    mkdir -p ~/lib/openPMD-api
    mkdir -p ~/lib/pngwriter
    mkdir -p ~/lib/ADIOS2
    export SCRATCH=~/scratch
    mkdir -p ~/picInputs
    mkdir -p $SCRATCH/runs
    mkdir -p ~/scratch
    mkdir -p ~/simulations

# Set system variables
    export PICSRC=~/src/picongpu
    export PIC_EXAMPLES=$PICSRC/share/picongpu/examples
    #export PIC_BACKEND="omp2b:native"
    #export PIC_BACKEND="cuda:61"
    export PIC_BACKEND="cuda:86"
    export PIC_CLONE=~/picInputs
    export PIC_CFG=etc/picongpu
    export PIC_OUTPUT=$SCRATCH/runs

    export PATH=$PATH:$PICSRC:$PICSRC/bin:$PICSRC/src/tools/bin
    export PYTHONPATH=$PICSRC/lib/python:$PYTHONPATH

# Load gcc - accomplished in Dependencies
#    apt -y install build-essential

# Load CMake - accomplished in Dependencies
#    apt -y install cmake file cmake-curses-gui

# Load openmpi
    sudo apt -y install libopenmpi-dev

# Load zlib
    sudo apt -y install zlib1g-dev

# Load boost Installs version 1.74.0
    sudo apt -y install libboost-program-options-dev libboost-filesystem-dev libboost-system-dev libboost-math-dev libboost-serialization-dev

# Load git - accomplished in Dependencies
#    sudo apt -y install git

# Load rsync - accomplished in Dependencies
#    sudo apt -y install rsync

# Retrieve PIConGPU source code and change to the -dev branch
    cd ~/src
    git clone https://github.com/kimjohn1/picongpu.git
    cd picongpu
    git checkout dev_2
    cd ~/

# Load libpng
    cd ~/
    sudo apt -y install libpng-dev

# Load pngwriter
    cd ~/src
    git clone https://github.com/pngwriter/pngwriter.git
    cd pngwriter-build
    cmake -DCMAKE_INSTALL_PREFIX=~/lib/pngwriter ~/src/pngwriter
    make install -j8
    cd ~/

    export CMAKE_PREFIX_PATH=~/lib/pngwriter:$CMAKE_PREFIX_PATH
    export LD_LIBRARY_PATH=~/lib/pngwriter/lib:$LD_LIBRARY_PATH

# Load hdf5 - apt installs version 1.10.4
    cd ~/
    sudo apt -y install libhdf5-openmpi-dev

# Load ADIOS2 - installs latest version
    cd ~/src
    git clone https://github.com/ornladios/ADIOS2.git ADIOS2
    cd ADIOS2-build
    cmake -DCMAKE_INSTALL_PREFIX=~/lib/ADIOS2 -DADIOS2_USE_Fortran=OFF -DADIOS2_USE_PNG=OFF -DADIOS2_USE_BZip2=OFF -DADIOS2_USE_SST=ON ~/src/ADIOS2
    make install -j8
    cd ~/

    export CMAKE_PREFIX_PATH=~/lib/ADIOS2:$CMAKE_PREFIX_PATH
    export LD_LIBRARY_PATH=~/lib/ADIOS2/lib:$LD_LIBRARY_PATH

# Load openpmd - Loads openPMD version 0.16.0
    cd ~/src
    git clone https://github.com/kimjohn1/openPMD-api.git
    cd openPMD-api
    git checkout 0.16.0
    cd ../openPMD-api-build
    cmake -DCMAKE_INSTALL_PREFIX=~/lib/openPMD-api -DopenPMD_USE_MPI=ON -DopenPMD_USE_ADIOS2=ON -DopenPMD_USE_HDF5=ON ~/src/openPMD-api
    make install -j8
    cd ~/

    export CMAKE_PREFIX_PATH=~/lib/openPMD-api:$CMAKE_PREFIX_PATH
    export LD_LIBRARY_PATH=~/lib/openPMD-api/lib:$LD_LIBRARY_PATH

# Install Qt6
    mkdir -p ~/Qt
    sudo apt -y install python3-pip
    pip3 install aqtinstall
    python3 -m aqt install-qt --outputdir ~/Qt linux desktop 6.3.1 gcc_64


# Install OpenVisus
# From: https://github.com/sci-visus/OpenVisus/blob/master/docs/compilation.md

# Additional Dependencies
    cd ~/
    sudo apt install -y patchelf
    sudo apt install -y swig
    sudo apt install -y mesa-common-dev
    python3 -m pip install numpy
    pip install --force-reinstall numpy==1.26.2

# Install Qt5
    python3 -m aqt install-qt --outputdir ~/Qt linux desktop 5.15.2 gcc_64

# Get the repo and compile OpenVisus Note: the cmake flag below may need to be changed from -DQt5_DIR=~/Qt/5.15.2 ... to -DQt_DIR=~/Qt/5.15.2 ...
    git clone https://github.com/sci-visus/OpenVisus
    cd OpenVisus
    mkdir build
    cd build

    cmake -DPython_EXECUTABLE=$(which python3) -DQt5_DIR=~/Qt/5.15.2/gcc_64/lib/cmake -DVISUS_GUI=1 _DVISUS_MODVISUS=0 ../
    cmake --build ./ --target all     --config Release -j 8 
    cmake --build ./ --target install --config Release

# Configure for OpenVisus
    PYTHONPATH=$(pwd)/Release python3 -m OpenVisus configure

# Note, you can run OpenVisus viewer using this command
    #PYTHONPATH=$(pwd)/Release python3 -m OpenVisus viewer #from the /home/kj/OpenVisus/build directory
    #or
    #PYTHONPATH=/home/kj/OpenVisus/build/Release python3 -m OpenVisus viewer #from anywhere
    #or
    #PYTHONPATH=~/OpenVisus/build/Release python3 -m OpenVisus viewer #from anywhere

# Set up desktop launchers
    cd ~/
    sudo cp support/M_Res.png /usr/share/icons
    cp support/Visus ~/Desktop
    chmod +rwx ~/Desktop/Visus
    chmod +rwx ~/launch_visus.sh

    sudo cp support/nvidia.png /usr/share/icons
    cp support/settings.desktop ~/Desktop
    chmod +rwx ~/Desktop/settings.desktop

