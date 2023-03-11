#!/usr/bin/env bash

cd "$(dirname "$0")"

echo ""
echo "----- setting up profiles  -----"
echo ""
cp  ../profiles/.bashrc ~/
cp  ../profiles/.zshrc ~/

echo ""
echo "----- setting up themes  -----"
echo ""
cp  ../themes/tokyo-night.zsh-theme ~/.oh-my-zsh/themes
cp  ../themes/calm.zsh-theme ~/.oh-my-zsh/themes
cp  ../themes/starship.toml ~/.config

echo ""
echo "----- setting up nvim config  -----"
echo ""
mkdir -p ~/.config/nvim
cp ../nvim/*.lua ~/.config/nvim/

echo "----- done  -----"
