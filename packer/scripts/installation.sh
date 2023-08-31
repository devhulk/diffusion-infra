#!/bin/bash

echo "Handling Package upgrades and Base Deps..."

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt update -y
sudo apt upgrade -y
sudo apt-get update -y && sudo apt-get install ffmpeg libsm6 libxext6  -y

echo "Make sure Python and Pip is Installed..."

# All the python weirdness
sudo apt install -y libgl1 libglib2.0-0
sudo apt install software-properties-common -y
sudo apt install -y python3
sudo apt install -y python3-pip
sudo apt install -y python3-venv 
pip3 install markupsafe==2.0.1
pip3 install --upgrade requests

sudo apt install -y hwinfo 

sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt install python3.10 -y
sudo apt install python3.10-venv -y

echo "Installing nvidia drivers..."
sudo apt-get install linux-headers-$(uname -r) -y
distribution=$(. /etc/os-release;echo $ID$VERSION_ID | sed -e 's/\.//g')
wget https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/cuda-keyring_1.0-1_all.deb
sudo dpkg -i cuda-keyring_1.0-1_all.deb
sudo apt-get update -y

# Make sure Cuda is set up
echo "Making sure Cuda is set up..."
sudo apt-get install cuda-drivers -y
echo 'export PATH=/usr/local/cuda-12.2/bin${PATH:+:${PATH}}' >> ~/.profile
echo 'export LD_LIBRARY_PATH=/usr/local/cuda-12.2/lib64\
                         ${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}' >> ~/.profile





echo "Starting AUTOMATIC1111 Stable Diffusion Install"

git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git

echo "Configuring NGINX"

sudo apt install nginx -y
sudo systemctl status nginx
sudo ufw allow 'Nginx HTTP'
sudo mv ~/nginx.conf /etc/nginx/nginx.conf
sudo systemctl restart nginx
sudo systemctl status nginx


echo "Setting up Stable Diffusion Systemd Service..."

sudo mv ~/stablediffusion.service /lib/systemd/system/stablediffusion.service
sudo systemctl daemon-reload
sudo systemctl enable stablediffusion.service
sudo systemctl start stablediffusion.service
sudo systemctl status stablediffusion.service

echo "Downloading some test Models..."

curl -L https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors -o ~/stable-diffusion-webui/models/Stable-diffusion/sd_xl_base_1.0.safetensors
wget -P ~/stable-diffusion-webui/models/Stable-diffusion https://civitai.com/api/download/models/128713 --content-disposition
wget -P ~/stable-diffusion-webui/models/Stable-diffusion https://civitai.com/api/download/models/143906 --content-disposition
