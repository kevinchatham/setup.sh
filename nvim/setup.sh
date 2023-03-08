#!/usr/bin/env bash

cd "$(dirname "$0")"

echo "--- installing nvim ----"
sudo apt install build-essential -y
sudo apt install neovim -y

echo "--- done  ---"
chmod +x setup_config_only.sh
./setup_config_only.sh
