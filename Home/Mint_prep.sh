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
#    cd ~/
#    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
#    sudo mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
#    wget https://developer.download.nvidia.com/compute/cuda/12.1.0/local_installers/cuda-repo-ubuntu2204-12-1-local_12.1.0-530.30.02-1_amd64.deb
#    sudo dpkg -i cuda-repo-ubuntu2204-12-1-local_12.1.0-530.30.02-1_amd64.deb
#    sudo cp /var/cuda-repo-ubuntu2204-12-1-local/cuda-*-keyring.gpg /usr/share/keyrings/
#    sudo apt update
#    DEBIAN_FRONTEND=noninteractive sudo apt -y install cuda
#    cd ~/
#    rm -rf cuda-repo-ubuntu2204-12-1-local_12.1.0-530.30.02-1_amd64.deb

# Alternative manual installation (I use this one)
# wget https://developer.download.nvidia.com/compute/cuda/12.1.0/local_installers/cuda_12.1.0_530.30.02_linux.run
# sudo sh cuda_12.1.0_530.30.02_linux.run

# Select Continue when the caution message appears
# Accept the EULA
# De-select the driver, demo and documentation in the little UI that appears


# Set the PATH (do the steps manually if desired using sudo su then: echo "export PATH=/usr/local/cuda-12.1/bin${PATH:+:${PATH}}" >> /etc/profile)

#sudo su <<EOF
#echo "export PATH=/usr/local/cuda-12.1/bin${PATH:+:${PATH}}" >> /etc/profile
#EOF

# Reboot
echo ""
echo "*********************************"
echo ""
echo "Please reboot your system now"
echo "Reboot is required for the changes just made to take effect"

