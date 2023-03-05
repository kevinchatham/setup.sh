#!/usr/bin/env bash

cd "$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

echo "--- setting up nvim config  ---"
mkdir -p ~/.config/nvim
cp ./*.lua ~/.config/nvim/

echo "--- done  ---"
