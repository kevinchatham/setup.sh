#!/usr/bin/env bash

# $PSScriptRoot in shell
cd $(pwd)

echo "----- granting execute ------"
chmod +x ./nvim/setup_config_only.sh
chmod +x ./setup_config_only.sh
chmod +x ./nvim/backup.sh
chmod +x ./backup.sh

echo "----- system updates ------"
sudo apt update && sudo apt upgrade

echo "----- configuring ssh ------"
sudo apt install openssh-server -y
sudo service ssh start

echo "----- configuring git ------"
git config --global user.name kevinchatham
git config --global user.email 40923272+kevinchatham@users.noreply.github.com
git config --global credential.helper store
git config --global init.defaultBranch main

echo "----- installing zsh ------"
sudo apt install zsh -y

echo "----- installing oh my zsh ------"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp ./themes/calm.zsh-theme ~/.oh-my-zsh/themes/calm.zsh-theme
cp ./themes/tokyo-night.zsh-theme ~/.oh-my-zsh/themes/tokyo-night.zsh-theme

echo "----- installing zsh auto suggestions ------"
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/plugins/zsh-autosuggestions

echo "----- installing zsh syntax highlighting ------"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting

echo "----- installing profiles ------"
cp .bashrc ~/.bashrc
cp .zshrc ~/.zshrc

echo "----- installing nvim ------"
chmod +x nvim/setup.sh
./nvim/setup.sh

echo "----- installing neofetch ------"
sudo apt install neofetch -y

echo "----- installing fira code ------"
sudo apt install fonts-firacode -y

echo "----- installing azure cli ------"
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

echo "----- installing dotnet 6.0 ------"
sudo apt install -y dotnet-sdk-6.0

echo "----- installing powershell ------"
sudo apt install -y wget apt-transport-https software-properties-common
wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt update
sudo apt install -y powershell
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
. ./nvm.sh

echo "----- allowing legacy dependencies ------"
npm config set legacy-peer-deps true

echo "----- installing node lts ------"
nvm install --lts

echo "----- installing npm latest ------"
npm install -g npm

echo "----- installing gtop ------"
npm install -g gtop

echo "----- installing eslint ------"
npm install -g eslint

echo "----- cleaning up ------"
sudo apt autoremove -y

echo "----- finished ------"

# echo "----- installing open jdk 11 ------"
# sudo apt install openjdk-8-jdk -y
# sudo apt install openjdk-11-jdk -y
# sudo apt install openjdk-17-jdk -y
# sudo apt install openjdk-19-jdk -y

# echo "----- installing maven 3.8.4 ------"
# # https://linuxize.com/post/how-to-install-apache-maven-on-ubuntu-20-04/#installing-the-latest-release-of-apache-maven
# wget https://archive.apache.org/dist/maven/maven-3/3.8.4/binaries/apache-maven-3.8.4-bin.tar.gz -P /tmp
# sudo tar xf /tmp/apache-maven-*.tar.gz -C /opt
# sudo ln -s /opt/apache-maven-3.8.4 /opt/maven # sym link When a new version is released, you can upgrade your Maven installation, by unpacking the newer version and change the symlink to point to it.
# sudo cp ./java/maven.sh /etc/profile.d/
# sudo chmod +x /etc/profile.d/maven.sh
# . /etc/profile.d/maven.sh
