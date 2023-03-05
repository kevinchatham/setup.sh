#!/usr/bin/env bash

cd "$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

echo "--- backing up nvim  ---"

cp ~/.config/nvim/*.lua .

echo "--- done  ---"
