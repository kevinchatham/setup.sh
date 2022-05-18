#!/bin/bash

sudo add-apt-repository universe
sudo apt update && sudo apt upgrade -y

echo "----- configuring git ------"
git config --global user.name kevinchatham
git config --global user.email 40923272+kevinchatham@users.noreply.github.com

echo "----- installing zsh ------"
sudo apt install zsh -y

echo "----- installing oh my zsh ------"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
rm  -rf ~/.oh-my-zsh/.git
cp ~/wsl-ubuntu-setup/calm.zsh-theme ~/.oh-my-zsh/themes/calm.zsh-theme 

echo "----- installing zsh auto suggestions ------"
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/plugins/zsh-autosuggestions

echo "----- installing zsh syntax highlighting ------"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting

echo "----- installing neofetch ------"
sudo apt install neofetch -y

echo "----- installing fira code ------"
sudo apt install fonts-firacode -y

echo "----- installing azure cli ------"
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

echo "----- installing powershell ------"
sudo apt-get install -y wget apt-transport-https software-properties-common
wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get install -y powershell
rm packages-microsoft-prod.deb

echo "----- installing terraform ------"
sudo apt install wget unzip -y
TER_VER=$(curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1')
wget https://releases.hashicorp.com/terraform/${TER_VER}/terraform_${TER_VER}_linux_amd64.zip -O ~/terraform_${TER_VER}_linux_amd64.zip
unzip ~/terraform_${TER_VER}_linux_amd64.zip
sudo mv terraform /usr/local/bin/
rm ~/terraform_${TER_VER}_linux_amd64.zip

echo "----- installing sqlite ------"
sudo apt install sqlite3 -y

echo "----- installing nvm (node version manager) ------"
export NVM_DIR="$HOME/.nvm"
rm -rf ~/.nvm
git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
cd "$NVM_DIR"
git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)` | bash
. "$NVM_DIR/nvm.sh"
. ./nvm.sh
cd ~/wsl-ubuntu-setup

echo "----- installing node 16.15.0 ------"
nvm install 16.15.0

echo "----- installing angular cli ------"
npm install -g @angular/cli

echo "----- installing eslint ------"
npm install -g eslint

cp ~/wsl-ubuntu-setup/.bashrc ~/.bashrc
cp ~/wsl-ubuntu-setup/.zshrc ~/.zshrc

echo "----- finished ------"