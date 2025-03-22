# Install Dependencies

#    Use Software Manager to install Monado-service and Steam

# Create directories

    mkdir -p ~/Documents/Godot ~/Documents/Godot/Projects/
    mkdir -p ~/Documents/Godot/godot_pix ~/Documents/Godot/godot_videos/
    mkdir -p ~/Documents/Godot/Godot_Supplement/
    mkdir -p ~/Documents/alvr/

# Install Godot

    wget https://github.com/godotengine/godot/releases/download/4.3-stable/Godot_v4.3-stable_linux.x86_64.zip
    unzip Godot_v4.3-stable_linux.x86_64.zip
    sudo mv Godot_v4.3-stable_linux.x86_64 /usr/local/bin/godot

# Set up the desktop launcher
    sudo cp ~/support/M_Res.png /usr/share/icons
    cp ~/support/Godot.desktop ~/Desktop
    chmod +rwx ~/Desktop/Godot.desktop
    chmod +rwx ~/launch_run_godot.sh

# Set up the simple_wave Project
    cp -r ~/support/simple_wave/ ~/Documents/Godot/Projects/

# Install ScalarField2PNGSlice app
    cp -r ~/support/ScalarField2PNGSlice/ ~/
    chmod +rwx ~/ScalarField2PNGSlice/ScalarField2PNGSlice

# Install ALVR (Launcher)

    wget https://github.com/alvr-org/ALVR/releases/download/v20.11.1/alvr_launcher_linux.tar.gz
    tar -xzf alvr_launcher_linux.tar.gz -C ~/Documents/alvr/
    cd ~/Documents/alvr/alvr_launcher_linux
    chmod +rwx ~/Documents/alvr/alvr_launcher_linux/ALVR\ Launcher
    sudo mv ALVR\ Launcher /usr/local/bin/ALVRLauncher
    cd ~/
    
# Set up the ALVR desktop launcher
    cd ~/
    sudo cp support/ALVR.jpeg /usr/share/icons
    cp support/ALVR.desktop ~/Desktop/
    chmod +rwx ~/Desktop/ALVR.desktop
