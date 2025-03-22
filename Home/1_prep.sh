# This script can be used to install the CUDA Toolkit and the OpenVisus framework.
# Please note a couple of different options for using this script to get the CUDA Toolkit and OpenVisus installed:

# If there is an Nvidia driver version 530 or better already installed, then the recommended installation
# is to use the Alternative manual installation described below.  You should comment out the Install CUDA Toolkit v12-1 steps (may already be done)
# and then run this modified script to install dependencies and install OpenVisus, and step you through manually installing the CUDA Toolkit,
# being careful to not install the driver (that is in the last step where you de-select driver, demo and documentation).
#
# If there is a pre-530 Nvidia driver installed, you can remove that by using the Linux Driver Manager to install the Nouveau driver
# and then launch this (unmodified) script.  The script installs both the Nvidia Toolkit and a Driver.

# If you have the option in the Linux Driver Manager to install a version 530 or better Nvidia driver, you can do that, then manually
# install The CUDA Toolkit as described, and then launch this (modified) script.

# I prefer to install a driver (the recommended driver) using Driver Manager and then install CUDA Toolkit manually

# Note that this script uses data from the support folder that should be pasted to the home drive along with the 1_prep.sh script 



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
    wget https://developer.download.nvidia.com/compute/cuda/12.1.0/local_installers/cuda_12.1.0_530.30.02_linux.run

echo "Steps to follow"
echo "You will be prompted to enter a command"
echo "After you do that:"
echo "Wait for a small text based User Interface to appear"
echo "Select Continue when the caution message appears"
echo "Accept the EULA"
echo "De-select the driver, demo and documentation, then proceed with the install"
echo " "
echo "Enter the following command"
echo "sudo sh cuda_12.1.0_530.30.02_linux.run"

# Set the PATH (do the steps manually if desired using sudo su then: echo "export PATH=/usr/local/cuda-12.1/bin${PATH:+:${PATH}}" >> /etc/profile)

#echo "Setting CUDA path now"
sudo su <<EOF
echo "export PATH=/usr/local/cuda-12.1/bin${PATH:+:${PATH}}" >> /etc/profile
EOF
#echo "CUDA path is set"

    #rm -rf cuda_12.1.0_530.30.02_linux.run

# Reboot
#echo ""
#echo "*********************************"
echo ""
echo "After the CUDA installation is complete, remember to reboot your system"
echo "Reboot is required for the changes made during installation to take effect"

