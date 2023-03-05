#/usr/bin/env bash

cd "$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

echo "--- backing up zsh  ---"
cp ~/.zshrc .zshrc
cp ~/.oh-my-zsh/themes/tokyo-night.zsh-theme ./themes/tokyo-night.zsh-theme
cp ~/.oh-my-zsh/themes/calm.zsh-theme ./themes/calm.zsh-theme

echo "--- done  ---"
chmod +x ./nvim/backup.sh
./nvim/backup.sh
