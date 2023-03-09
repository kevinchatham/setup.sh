#!/usr/bin/env bash

cd "$(dirname "$0")"

echo "--- setting up zsh config  ---"
cp  ../profiles/.zshrc ~/.zshrc
cp  ../themes/tokyo-night.zsh-theme ~/.oh-my-zsh/themes/tokyo-night.zsh-theme
cp  ../themes/calm.zsh-theme ~/.oh-my-zsh/themes/calm.zsh-theme

echo "--- setting up nvim config  ---"
mkdir -p ~/.config/nvim
cp ../nvim/*.lua ~/.config/nvim/

echo "--- done  ---"

