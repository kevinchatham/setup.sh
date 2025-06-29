#!/usr/bin/env bash

cd "$(dirname "$0")" # script root

export OWD="$(pwd)"

echo ""
echo "----- granting execute -----"
echo ""
chmod +x ./scripts/backup-config.sh
chmod +x ./scripts/setup-config.sh

echo ""
echo "----- system updates -----"
echo ""
sudo apt update && sudo apt upgrade

echo ""
echo "----- increasing file watcher count -----"
echo ""
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf

echo ""
echo "----- configuring git -----"
echo ""
sudo apt install git -y
git config --global user.name kevinchatham
git config --global user.email 40923272+kevinchatham@users.noreply.github.com

echo ""
echo "----- installing curl -----"
echo ""
sudo apt install curl -y

echo ""
echo "----- installing zsh -----"
echo ""
sudo apt install zsh -y

echo ""
echo "----- installing starship -----"
echo ""
curl -sS https://starship.rs/install.sh | sh

echo ""
echo "----- installing oh my zsh -----"
echo ""
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp ./themes/calm.zsh-theme ~/.oh-my-zsh/themes/calm.zsh-theme
cp ./themes/tokyo-night.zsh-theme ~/.oh-my-zsh/themes/tokyo-night.zsh-theme

echo ""
echo "----- installing zsh auto suggestions -----"
echo ""
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/plugins/zsh-autosuggestions

echo ""
echo "----- installing zsh syntax highlighting -----"
echo ""
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting

echo ""
echo "----- installing neofetch -----"
echo ""
sudo apt install neofetch -y

echo ""
echo "----- installing azure cli -----"
echo ""
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

echo ""
echo "----- installing dotnet 9.0 -----"
echo ""
sudo apt install -y dotnet-sdk-9.0

echo ""
echo "----- installing htop -----"
echo ""
sudo apt install -y htop

echo ""
echo "----- installing powershell -----"
echo ""
sudo apt install -y wget apt-transport-https software-properties-common
wget -q https://packages.microsoft.com/config/ubuntu/25.10/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt update
sudo apt install -y powershell
rm packages-microsoft-prod.deb

echo ""
echo "----- installing terraform -----"
echo ""
sudo apt install wget unzip -y
ARCH=$(uname -m)
TER_ARCH=""
if [[ "$ARCH" == "x86_64" ]]; then
    TER_ARCH="amd64"
elif [[ "$ARCH" == "aarch64" || "$ARCH" == "arm64" ]]; then
    TER_ARCH="arm64"
fi

if [[ -z "$TER_ARCH" ]]; then
    echo "Warning: Unsupported architecture for Terraform ($ARCH). Skipping Terraform installation."
else
    TER_VER=$(curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
    wget "https://releases.hashicorp.com/terraform/${TER_VER}/terraform_${TER_VER}_linux_${TER_ARCH}.zip" -O ~/terraform.zip
    unzip -o ~/terraform.zip -d ~/
    sudo mv ~/terraform /usr/local/bin/
    rm ~/terraform.zip
fi

echo ""
echo "----- installing sqlite -----"
echo ""
sudo apt install sqlite3 -y

echo ""
echo "----- cleaning up -----"
echo ""
sudo apt autoremove -y

echo ""
echo "----- installing configurations -----"
echo ""
./scripts/setup-config.sh

echo ""
echo "----- installing nvm (node version manager) -----"
echo ""
export NVM_DIR="$HOME/.nvm"
rm -rf ~/.nvm
git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
cd "$NVM_DIR"
git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)` | bash
. ./nvm.sh # last overall step because of this

echo ""
echo "----- installing node lts -----"
echo ""
nvm install --lts

echo ""
echo "----- installing npm latest -----"
echo ""
npm install -g npm

echo ""
echo "----- finished -----"
echo ""

cd ~

exec bash

# echo "----- installing open jdk 11 -----"
# sudo apt install openjdk-8-jdk -y
# sudo apt install openjdk-11-jdk -y
# sudo apt install openjdk-17-jdk -y
# sudo apt install openjdk-19-jdk -y

# echo "----- installing maven 3.8.4 -----"
# # https://linuxize.com/post/how-to-install-apache-maven-on-ubuntu-20-04/#installing-the-latest-release-of-apache-maven
# wget https://archive.apache.org/dist/maven/maven-3/3.8.4/binaries/apache-maven-3.8.4-bin.tar.gz -P /tmp
# sudo tar xf /tmp/apache-maven-*.tar.gz -C /opt
# sudo ln -s /opt/apache-maven-3.8.4 /opt/maven # sym link When a new version is released, you can upgrade your Maven installation, by unpacking the newer version and change the symlink to point to it.
# sudo cp ./java/maven.sh /etc/profile.d/
# sudo chmod +x /etc/profile.d/maven.sh
# . /etc/profile.d/maven.sh
