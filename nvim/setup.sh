#!/usr/bin/env bash

cd $(pwd)

export OD=$(pwd)

echo "--- installing nvim ----"
sudo apt install build-essential -y
mkdir -p ~/.nvim
cd ~/.nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract

cd $(pwd)

echo "--- done  ---"
chmod +x setup_config_only.sh
./setup_config_only.sh
