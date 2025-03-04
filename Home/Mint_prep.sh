# Install dependencies
    sudo apt update
    sudo apt -y install build-essential
    sudo apt -y install wget
    sudo apt -y install curl
    sudo apt -y install python3
    sudo apt -y install cmake file cmake-curses-gui
    sudo apt -y install libgl1-mesa-dev
	sudo apt -y install libglfw3-dev libglu1-mesa-dev
    sudo apt -y install libffi-dev
    sudo apt -y install git
    sudo apt -y install rsync
    sudo apt -y install qt6-base-dev
    sudo apt -y install qt6-tools-dev
    sudo apt -y install libxkbcommon-dev
    sudo apt -y install xorg
    sudo apt -y install libdbus-1-dev #new requirement for QT6 discovered 12 Nov 2024

# Install CUDA Toolkit v12-1
#   cd ~/
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
    sudo mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
    wget https://developer.download.nvidia.com/compute/cuda/12.8.0/local_installers/cuda-repo-ubuntu2204-12-8-local_12.8.0-570.86.10-1_amd64.deb
    sudo dpkg -i cuda-repo-ubuntu2204-12-8-local_12.8.0-570.86.10-1_amd64.deb
    sudo cp /var/cuda-repo-ubuntu2204-12-8-local/cuda-*-keyring.gpg /usr/share/keyrings/
    sudo apt update
    DEBIAN_FRONTEND=noninteractive sudo apt -y install cuda
    cd ~/
    rm -rf cuda-repo-ubuntu2204-12-8-local_12.8.0-570.86.10-1_amd64.deb

# Alternative manual installation (I use this one)
# wget https://developer.download.nvidia.com/compute/cuda/12.1.0/local_installers/cuda_12.1.0_530.30.02_linux.run
# sudo sh cuda_12.1.0_530.30.02_linux.run

# Select Continue when the caution message appears
# Accept the EULA
# De-select the driver, demo and documentation in the little UI that appears


# Set the PATH (do the steps manually if desired using sudo su then: echo "export PATH=/usr/local/cuda-12.1/bin${PATH:+:${PATH}}" >> /etc/profile)

sudo su <<EOF
echo "export PATH=/usr/local/cuda-12.8/bin${PATH:+:${PATH}}" >> /etc/profile
EOF

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
    mkdir ~/Qt
    sudo apt -y install python3-pip
    pip3 install aqtinstall
    python3 -m aqt install-qt --outputdir ~/Qt linux desktop 5.15.2 gcc_64

# Get the repo and compile OpenVisus Note: the cmake flag below may need to be changed from -DQt5_DIR=~/Qt/5.15.2 ... to -DQt_DIR=~/Qt/5.15.2 ...
    git clone https://github.com/sci-visus/OpenVisus
    cd OpenVisus
    mkdir build
    cd build

    cmake -DPython_EXECUTABLE=$(which python3) -DQt5_DIR=~/Qt/5.15.2/gcc_64/lib/cmake -DVISUS_GUI=1 _DVISUS_MODVISUS=0 ../
    cmake --build ./ --target all     --config Release -j 16 
    cmake --build ./ --target install --config Release

# Configure for OpenVisus
    PYTHONPATH=$(pwd)/Release python3 -m OpenVisus configure

# Run OpenVisus viewer - execute this command manually
    #PYTHONPATH=$(pwd)/Release python3 -m OpenVisus viewer #from the /home/kj/OpenVisus/build directory
    #or
    #PYTHONPATH=/home/kj/OpenVisus/build/Release python3 -m OpenVisus viewer #from anywhere
    #or
    #PYTHONPATH=~/OpenVisus/build/Release python3 -m OpenVisus viewer #from anywhere

# Set up the desktop launcher
    cd ~/
    sudo cp support/SCIRun_4.png /usr/share/icons
    cp support/Viewer.desktop ~/Desktop
    chmod +rwx ~/Desktop/Viewer.desktop
    #cp support/launch_visus.sh ~/
    chmod +rwx ~/launch_visus.sh

# Reboot
echo ""
echo "*********************************"
echo ""
echo "Please reboot your system now"
echo "Reboot is required for the changes just made to take effect"

