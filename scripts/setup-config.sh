#!/usr/bin/env bash

cd "$(dirname "$0")"

echo "----- setting up profiles  -----"
cp  ../profiles/.bashrc ~/
cp  ../profiles/.zshrc ~/

echo "----- setting up themes  -----"
cp  ../themes/tokyo-night.zsh-theme ~/.oh-my-zsh/themes
cp  ../themes/calm.zsh-theme ~/.oh-my-zsh/themes
cp  ../themes/starship.toml ~/.config

echo "----- setting up nvim config  -----"
mkdir -p ~/.config/nvim
cp ../nvim/*.lua ~/.config/nvim/

echo "----- done  -----"
