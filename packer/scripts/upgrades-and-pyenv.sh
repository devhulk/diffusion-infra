#!/bin/bash

export DEBIAN_FRONTEND=noninteractive


echo "Handling Package upgrades and Base Deps..."

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt update -y
sudo apt upgrade -y
sudo apt-get update -y && sudo apt-get install ffmpeg libsm6 libxext6  -y

echo "Installing pyenv"

sudo apt-get update; sudo apt-get install make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev  -y

curl https://pyenv.run | bash

