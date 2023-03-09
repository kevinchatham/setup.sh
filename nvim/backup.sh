#!/usr/bin/env bash

cd $(pwd)

echo "--- backing up nvim  ---"

cp ~/.config/nvim/*.lua .

echo "--- done  ---"
