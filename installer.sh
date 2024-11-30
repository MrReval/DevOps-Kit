#!/bin/bash

echo "Cloning the repository from GitHub..."
git clone https://github.com/MrReval/DevOps-Kit.git

cd DevOps-Kit

echo "Starting Docker installation..."

if ! command -v docker &> /dev/null
then
    echo "Docker not found. Installing Docker..."
    cd install
    chmod +x install_docker.sh 
    ./install_docker.sh  
else
    echo "Docker is already installed."
fi

echo "Setting up execute permissions for scripts..."
chmod +x scripts/manage_containers.sh 

echo "Running manage_containers.sh..."
./scripts/manage_containers.sh 

echo "Creating a shortcut for 'DevOps-Kit' command..."
sudo ln -s $(pwd)/scripts/manage_containers.sh /usr/local/bin/DevOps-Kit

echo "Installation complete! Your DevOps Kit is ready to use."
echo "You can now use the 'DevOps-Kit' command from anywhere to run the manage_containers.sh script."
