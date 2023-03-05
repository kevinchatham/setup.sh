#!/usr/bin/env bash

echo "----- installing neovim ------"
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt install build-essential -y
sudo apt install neovim -y
mkdir -p ~/.config/nvim
cp init.lua ~/.config/nvim/init.lua
