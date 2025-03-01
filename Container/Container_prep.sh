# Install dependencies
    sudo apt update
    sudo apt -y install git

# Create new directories
    mkdir ~/scratch
    mkdir ~/simulations
    mkdir ~/picInputs

# Load data to the directories
    git clone https://github.com/kimjohn1/picongpu.git
    cd picongpu
    git checkout container_2
    cd ~/
    cp -a ~/picongpu/share/picongpu/examples/* ~/simulations
    rm -rf ~/picongpu
    cp -a S-support/networks ~/Documents
    cp -a S-support/sim_out ~/Documents

# Set up the desktop launcher
    sudo cp S-support/e-density.png /usr/share/icons
    cp S-support/SCIRun-PT.desktop ~/Desktop
    chmod +rwx ~/Desktop/SCIRun-PT.desktop

#Install the CUDA Toolkit
    cd ~/
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
    sudo mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
    wget https://developer.download.nvidia.com/compute/cuda/12.1.0/local_installers/cuda-repo-ubuntu2204-12-1-local_12.1.0-530.30.02-1_amd64.deb
    sudo dpkg -i cuda-repo-ubuntu2204-12-1-local_12.1.0-530.30.02-1_amd64.deb
    sudo cp /var/cuda-repo-ubuntu2204-12-1-local/cuda-*-keyring.gpg /usr/share/keyrings/
    sudo apt update
    DEBIAN_FRONTEND=noninteractive sudo apt -y install cuda
    cd ~/

# Install Singularity
    cd ~/Downloads
    wget https://github.com/apptainer/singularity/releases/download/v3.8.7/singularity-container_3.8.7_amd64.deb
    sudo dpkg -i singularity-container_3.8.7_amd64.deb
    cd ~/

# Set the PATH
sudo su <<EOF
echo "export PATH=/usr/local/cuda-12.1/bin${PATH:+:${PATH}}" >> /etc/profile
EOF

# Delete unnecessary files
    rm -rf ~/cuda-repo-ubuntu2204-12-1-local_12.1.0-530.30.02-1_amd64.deb
    rm -rf ~/Downloads/singularity-container_3.8.7_amd64.deb
    rm -rf ~/S-support
    #rm -f ~/scirun-picongpu_prep.sh

# Reboot
echo ""
echo "*********************************"
echo ""
echo "Please reboot your system now"
echo "Reboot is required for the changes just made to take effect"

# Run the container

#singularity run --fakeroot --writable --bind /run,picInputs:/Project/picInputs,simulations:/Project/src/picongpu/share/picongpu/examples,scratch:/Project/scratch scirun_picongpu.sif
