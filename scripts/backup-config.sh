#!/usr/bin/env bash

cd "$(dirname "$0")"

echo "----- backing up profiles  -----"
cp ~/.bashrc ../profiles/.bashrc
cp ~/.zshrc ../profiles/.zshrc

echo "----- backing up themes  -----"
cp ~/.oh-my-zsh/themes/tokyo-night.zsh-theme ../themes
cp ~/.oh-my-zsh/themes/calm.zsh-theme ../themes
cp ~/.config/starship.toml ../themes

echo "----- backing up nvim  -----"
cp ~/.config/nvim/*.lua ../nvim

echo "----- done  -----"
