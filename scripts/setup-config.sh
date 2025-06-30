#!/usr/bin/env bash

cd "$(dirname "$0")"

echo "    ➡️  Setting up shell profiles (.bashrc, .zshrc)..."
cp  ../profiles/.bashrc ~/
cp  ../profiles/.zshrc ~/

echo "    ➡️  Setting up themes..."
cp  ../themes/tokyo-night.zsh-theme ~/.oh-my-zsh/themes
cp  ../themes/calm.zsh-theme ~/.oh-my-zsh/themes
mkdir -p ~/.config
cp  ../themes/starship.toml ~/.config

echo "    ➡️  Setting up nvim config..."
mkdir -p ~/.config/nvim
cp ../nvim/*.lua ~/.config/nvim/

echo "✅ Custom configurations applied."
