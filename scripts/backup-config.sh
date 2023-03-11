#!/usr/bin/env bash

cd "$(dirname "$0")"

echo ""
echo "----- backing up profiles  -----"
echo ""
cp ~/.bashrc ../profiles/.bashrc
cp ~/.zshrc ../profiles/.zshrc

echo ""
echo "----- backing up themes  -----"
echo ""
cp ~/.oh-my-zsh/themes/tokyo-night.zsh-theme ../themes
cp ~/.oh-my-zsh/themes/calm.zsh-theme ../themes
cp ~/.config/starship.toml ../themes

echo ""
echo "----- backing up nvim  -----"
echo ""
cp ~/.config/nvim/*.lua ../nvim

echo "----- done  -----"
