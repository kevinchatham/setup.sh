#!/usr/bin/env bash

cd $(pwd)

echo "--- setting up nvim config  ---"
mkdir -p ~/.config/nvim
cp ./*.lua ~/.config/nvim/

echo "--- done  ---"
