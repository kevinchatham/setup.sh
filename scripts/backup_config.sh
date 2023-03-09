#!/usr/bin/env bash

cd "$(dirname "$0")"

echo "--- backing up zsh  ---"
cp ~/.zshrc ../profiles/.zshrc
cp ~/.oh-my-zsh/themes/tokyo-night.zsh-theme ../themes/tokyo-night.zsh-theme
cp ~/.oh-my-zsh/themes/calm.zsh-theme ../themes/calm.zsh-theme

echo "--- backing up nvim  ---"
cp ~/.config/nvim/*.lua ../nvim

echo "--- done  ---"
