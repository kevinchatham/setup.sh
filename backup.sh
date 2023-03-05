#/usr/bin/env bash

cd $(pwd)

echo "--- backing up zsh  ---"
cp ~/.zshrc .zshrc
cp ~/.oh-my-zsh/themes/tokyo-night.zsh-theme ./themes/tokyo-night.zsh-theme
cp ~/.oh-my-zsh/themes/calm.zsh-theme ./themes/calm.zsh-theme

chmod +x ./nvim/backup.sh

./nvim/backup.sh

