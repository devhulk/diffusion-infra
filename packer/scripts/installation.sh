#!/bin/bash


export DEBIAN_FRONTEND=noninteractive

cat <<EOF >> ~/.profile
export PATH="$HOME/.pyenv/bin:$PATH"
eval $(pyenv init --path)
eval $(pyenv virtualenv-init -)
EOF

cat ~/.profile 

source ~/.profile

pyenv --version

pyenv install -v 3.10.6
pyenv global 3.10.6

echo "Make sure Python and Pip is Installed..."

# All the python weirdness
sudo apt install libgl1 libglib2.0-0 -y
sudo apt install software-properties-common -y
# Install right python version
#sudo apt install python3 -y 
#sudo apt install python3-pip -y 
#sudo apt install python3-venv -y 
pip install markupsafe==2.0.1
pip install --upgrade requests

sudo apt install -y hwinfo 

#sudo add-apt-repository ppa:deadsnakes/ppa -y
#sudo apt install python3.10 -y
#sudo apt install python3.10-venv -y


echo "Installing nvidia drivers..."
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt-get update -y
sudo apt-get -y install cuda
sudo apt-get -y install nvidia-gds


# Make sure Cuda is set up
echo "Making sure Cuda is set up..."
#sudo apt-get install cuda-drivers -y
echo 'export PATH=/usr/local/cuda-12.2/bin${PATH:+:${PATH}}' >> ~/.profile
echo 'export LD_LIBRARY_PATH=/usr/local/cuda-12.2/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}' >> ~/.profile


echo "Starting AUTOMATIC1111 Stable Diffusion Install"

git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git && cd stable-diffusion
python -m venv venv
cd ~/

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

# echo "Downloading some test Models..."

#curl -L https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors -o ~/stable-diffusion-webui/models/Stable-diffusion/sd_xl_base_1.0.safetensors
#wget -P ~/stable-diffusion-webui/models/Stable-diffusion https://civitai.com/api/download/models/128713 --content-disposition
#wget -P ~/stable-diffusion-webui/models/Stable-diffusion https://civitai.com/api/download/models/143906 --content-disposition
