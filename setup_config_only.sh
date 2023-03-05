#!/usr/bin/env bash

cd "$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

echo "--- setting up zsh config  ---"
cp  ./.zshrc ~/.zshrc
cp  ./themes/tokyo-night.zsh-theme ~/.oh-my-zsh/themes/tokyo-night.zsh-theme
cp  ./themes/calm.zsh-theme ~/.oh-my-zsh/themes/calm.zsh-theme

echo "--- done  ---"
chmod +x ./nvim/setup_config_only.sh
./nvim/setup_config_only.sh
