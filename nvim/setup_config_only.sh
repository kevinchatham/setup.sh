#!/usr/bin/env bash

cd "$(dirname "$0")"

echo "--- setting up nvim config  ---"
mkdir -p ~/.config/nvim
cp ./*.lua ~/.config/nvim/

echo "--- done  ---"
