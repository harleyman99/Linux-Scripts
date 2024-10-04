#!/bin/bash

echo "

             .__                                  .__                          
  ___________|__| ____   __  _  _______    ______ |  |__   ___________   ____  
_/ __ \_  __ \  |/ ___\  \ \/ \/ /\__  \  /  ___/ |  |  \_/ __ \_  __ \_/ __ \
\  ___/|  | \/  \  \___   \     /  / __ \_\___ \  |   Y  \  ___/|  | \/\  ___/ 
 \___  >__|  |__|\___  >   \/\_/  (____  /____  > |___|  /\___  >__|    \___  >
     \/              \/                \/     \/       \/     \/            \/ 

"
echo "This script is intended to install Packet Tracer on Ubuntu (and Ubuntu Based Systems)
This script is NOT MAINTAINED and may become defunct in the future.
Please ensure that you have Packet Tracer downloaded (the .deb version from NetAcad). "
############################################################################################
# Functions
function UbuntUpdate() {
  apt update -y
  apt upgrade -y
}

function GrabDepends() {

  # Define download URLs
  local url_mesa1="https://launchpad.net/ubuntu/+archive/primary/+files/libegl1-mesa_23.0.4-0ubuntu1%7E22.04.1_amd64.deb"
  local url_mesa2="https://launchpad.net/ubuntu/+archive/primary/+files/libgl1-mesa-glx_23.0.4-0ubuntu1%7E22.04.1_amd64.deb"

  # Define download locations (modify if needed)
  local file1="libegl1-mesa_23.0.4-0ubuntu1.22.04.1_amd64.deb"
  local file2="libgl1-mesa-glx_23.0.4-0ubuntu1.22.04.1_amd64.deb"

  # Check if files already exist
  if [[ -f "$file1" && -f "$file2" ]]; then
    echo "Files $file1 and $file2 already downloaded. Skipping download."
  else
    echo "Downloading dependencies..."
    wget -q "$url_mesa1" -O "$file1" && wget -q "$url_mesa2" -O "$file2" || echo "Download failed. Please check network connectivity."
  fi

  # Install dependencies using dpkg
  sudo dpkg -i "$file1" "$file2"
  #Install gdebi 
  apt install gdebi -y
}


function install_packet_tracer() {

  file_path=$(zenity --file-selection --title="Select the Packet Tracer File")
    if [[ -n "$file_path" ]]; then
     echo "Selected file: $file_path"
    else
     echo "No file selected."
  fi

  # Install Packet Tracer
  gdebi "$file_path"

  # Check for installation errors
  if [[ $? -eq 0 ]]; then
    echo "Packet Tracer installed successfully!"
  else
    echo "Error installing Packet Tracer. Please check the logs for more information."
  fi
}
#################################################################################################################################

# Update package lists
echo "Beginning Update Processss.."
UbuntUpdate

# Grab and install depedencies
echo "Installing Dependencies...."
GrabDepends

echo "Beginning Packet Tracer install...."
# Install Packet Tracer
install_packet_tracer