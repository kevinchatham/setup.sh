#!/usr/bin/env bash

cd $(pwd)

echo "--- installing nvim ----"
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt install build-essential -y
sudo apt install neovim -y

chmod +x setup_config_only.sh

./setup_config_only.sh

