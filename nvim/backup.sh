#!/usr/bin/env bash

cd "$(dirname "$0")"

echo "--- backing up nvim  ---"

cp ~/.config/nvim/*.lua .

echo "--- done  ---"
