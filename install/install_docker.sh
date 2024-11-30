#!/bin/bash
echo "Updating system..."
sudo apt update -y
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common git

echo "Installing Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update
sudo apt install -y docker-ce docker-compose

docker --version

sudo usermod -aG docker $USER
echo "Please log out and log back in."
