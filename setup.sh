#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Helper Functions ---
is_installed() {
    command -v "$1" &>/dev/null
}

# --- Installation Functions ---

system_setup() {
    echo "🔧 Granting execute permissions..."
    chmod +x ./scripts/backup-config.sh
    chmod +x ./scripts/setup-config.sh

    echo "🔄 Updating and upgrading system packages..."
    sudo apt update && sudo apt upgrade -y

    echo "⚙️  Increasing file watcher limit..."
    if ! grep -q "fs.inotify.max_user_watches=524288" /etc/sysctl.conf; then
        echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf
        sudo sysctl -p
    fi
}

install_core_dependencies() {
    echo "📦 Installing core dependencies..."
    sudo apt install -y git curl zsh neofetch htop sqlite3 wget unzip apt-transport-https software-properties-common
}

configure_git() {
    echo "📝 Configuring Git..."
    git config --global user.name kevinchatham
    git config --global user.email 40923272+kevinchatham@users.noreply.github.com
}

install_starship() {
    if ! is_installed starship; then
        echo "🚀 Installing Starship prompt..."
        curl -sS https://starship.rs/install.sh | sudo sh -s -- -y
    else
        echo "🚀 Starship is installed. Checking for updates by re-running the installer..."
        curl -sS https://starship.rs/install.sh | sudo sh -s -- -y
    fi
}

install_oh_my_zsh() {
    local ZSH_DIR="$HOME/.oh-my-zsh"
    if [ ! -d "$ZSH_DIR" ]; then
        echo "✨ Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    else
        echo "✨ Oh My Zsh is installed. Checking for updates..."
        "$ZSH_DIR/tools/upgrade.sh"
    fi
    
    echo "🎨 Setting up Zsh themes..."
    cp ./themes/calm.zsh-theme ~/.oh-my-zsh/themes/calm.zsh-theme
    cp ./themes/tokyo-night.zsh-theme ~/.oh-my-zsh/themes/tokyo-night.zsh-theme
    
    echo "🧩 Installing/updating Zsh plugins..."
    local ZSH_CUSTOM_PLUGINS="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
    local ZSH_AUTOSUGGESTIONS_DIR="$ZSH_CUSTOM_PLUGINS/zsh-autosuggestions"
    local ZSH_SYNTAX_HIGHLIGHTING_DIR="$ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting"

    if [ ! -d "$ZSH_AUTOSUGGESTIONS_DIR" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_AUTOSUGGESTIONS_DIR"
    else
        echo "   └── Updating zsh-autosuggestions..."
        git -C "$ZSH_AUTOSUGGESTIONS_DIR" pull
    fi

    if [ ! -d "$ZSH_SYNTAX_HIGHLIGHTING_DIR" ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_SYNTAX_HIGHLIGHTING_DIR"
    else
        echo "   └── Updating zsh-syntax-highlighting..."
        git -C "$ZSH_SYNTAX_HIGHLIGHTING_DIR" pull
    fi
}

install_azure_cli() {
    if ! is_installed az; then
        echo "☁️  Installing Azure CLI..."
        curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
    else
        echo "Azure CLI already installed, skipping. It will be updated by 'apt upgrade'."
    fi
}

install_dotnet() {
    if ! is_installed dotnet; then
        echo "📦 Installing .NET 9 SDK..."
        # Per https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu-install
        # .NET installation method depends on the OS and version.
        source /etc/os-release
        
        case "$ID" in
            ubuntu)
                case "$VERSION_ID" in
                    "24.04")
                        echo "Adding .NET backports PPA for Ubuntu 24.04 to install .NET 9."
                        sudo add-apt-repository -y ppa:dotnet/backports
                        sudo apt update
                        ;;
                    "24.10")
                        echo "Using standard Ubuntu 24.10 repository for .NET 9."
                        ;;
                    *)
                        echo "Warning: This script doesn't support automatic .NET 9 installation on Ubuntu ${VERSION_ID}."
                        echo "Skipping .NET installation. Please see https://dot.net/v1/dotnet-install.sh for manual installation."
                        return
                        ;;
                esac
                sudo apt install -y dotnet-sdk-9.0
                ;;
            debian)
                echo "Installing .NET 9 on Debian using the dotnet-install script."
                curl -L https://dot.net/v1/dotnet-install.sh -o dotnet-install.sh
                chmod +x ./dotnet-install.sh
                sudo ./dotnet-install.sh --channel 9.0 --install-dir /usr/share/dotnet
                sudo ln -sf /usr/share/dotnet/dotnet /usr/local/bin/dotnet
                rm ./dotnet-install.sh
                ;;
            *)
                echo "Warning: Unsupported distribution '$ID'. This script only supports Ubuntu and Debian for .NET installation."
                echo "Skipping .NET installation. Please see https://dot.net/v1/dotnet-install.sh for manual installation."
                ;;
        esac
    else
        source /etc/os-release
        if [[ "$ID" == "debian" ]]; then
            echo "📦 .NET is installed. Checking for updates on Debian..."
            curl -L https://dot.net/v1/dotnet-install.sh -o dotnet-install.sh
            chmod +x ./dotnet-install.sh
            sudo ./dotnet-install.sh --channel 9.0 --install-dir /usr/share/dotnet
            sudo ln -sf /usr/share/dotnet/dotnet /usr/local/bin/dotnet
            rm ./dotnet-install.sh
        else
            echo "Dotnet SDK already installed, skipping. It will be updated by 'apt upgrade'."
        fi
    fi
}

install_powershell() {
    if ! is_installed pwsh && ! [ -f "$HOME/.dotnet/tools/pwsh" ]; then
        echo "📦 Installing PowerShell as a .NET global tool..."
        # The --add-source is added to ensure we can find the package, even on preview SDKs.
        dotnet tool install --global PowerShell --add-source "https://api.nuget.org/v3/index.json"
    else
        echo "📦 PowerShell is installed. Checking for updates..."
        dotnet tool update --global PowerShell
    fi
    echo "✅ PowerShell is installed and up-to-date."
    echo "   └── Please ensure \"\$HOME/.dotnet/tools\" is in your PATH to use it."
}

trust_dotnet_dev_certs() {
    echo "🔐 Trusting .NET local development certificate..."
    dotnet dev-certs https --trust
    echo "   └── If prompted, please provide your password to trust the certificate."
}

install_terraform() {
    echo "📦 Ensuring Terraform is up to date..."
    local TER_ARCH
    case "$(uname -m)" in
        "x86_64") TER_ARCH="amd64" ;;
        "aarch64" | "arm64") TER_ARCH="arm64" ;;
        *)
            echo "Warning: Unsupported architecture for Terraform ($(uname -m)). Skipping Terraform installation."
            return
            ;;
    esac
    
    local LATEST_VER
    LATEST_VER=$(curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
    
    local INSTALLED_VER="0"
    if is_installed terraform; then
        INSTALLED_VER=$(terraform version | head -n 1 | awk '{print $2}' | tr -d 'v')
    fi

    if [[ "$LATEST_VER" != "$INSTALLED_VER" ]]; then
        if [[ "$INSTALLED_VER" != "0" ]]; then
            echo "   └── New version of Terraform found (v${LATEST_VER}). Currently on v${INSTALLED_VER}. Updating..."
        else
            echo "   └── Installing Terraform v${LATEST_VER}..."
        fi
        wget "https://releases.hashicorp.com/terraform/${LATEST_VER}/terraform_${LATEST_VER}_linux_${TER_ARCH}.zip" -O ~/terraform.zip
        unzip -o ~/terraform.zip -d ~/
        sudo mv ~/terraform /usr/local/bin/
        rm ~/terraform.zip
    else
        echo "   └── Terraform is already up to date (v${INSTALLED_VER})."
    fi
}

install_ssh_if_not_wsl() {
    echo "🔎 Checking for WSL environment..."
    # Check for WSL by looking for "Microsoft" in /proc/version. This is a common and reliable method.
    if grep -q -i "microsoft" /proc/version; then
        echo "└── WSL detected. Skipping SSH server installation."
    else
        echo "└── Not running in WSL. Installing and enabling SSH server..."
        sudo apt-get install -y openssh-server
        sudo systemctl enable --now ssh
        echo "    └── SSH server installed and started."
    fi
}

install_nvm_and_node() {
    echo "📦 Installing NVM (Node Version Manager)..."
    export NVM_DIR="$HOME/.nvm"
    if [ ! -d "$NVM_DIR" ]; then
        git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
        cd "$NVM_DIR"
        # Checkout the latest tagged version
        git checkout "$(git describe --abbrev=0 --tags --match "v[0-9]*" "$(git rev-list --tags --max-count=1)")"
        cd - > /dev/null
    else
        echo "📦 NVM is installed. Fetching latest changes..."
        (cd "$NVM_DIR" && git fetch --tags origin && git checkout "$(git describe --abbrev=0 --tags --match "v[0-9]*" "$(git rev-list --tags --max-count=1)")")
    fi

    # Source nvm script to use it in the current shell
    # shellcheck source=/dev/null
    . "$NVM_DIR/nvm.sh"

    echo "📦 Ensuring Node.js LTS is up to date..."
    nvm install --lts

    echo "📦 Ensuring npm is up to date..."
    npm install -g npm
}

main() {
    cd "$(dirname "$0")" # script root

    system_setup
    install_core_dependencies
    configure_git
    install_ssh_if_not_wsl
    install_starship
    install_oh_my_zsh
    install_azure_cli
    install_dotnet
    install_powershell
    trust_dotnet_dev_certs
    install_terraform
    
    echo "🧹 Cleaning up unused packages..."
    sudo apt autoremove -y

    echo "⚙️  Applying custom configurations..."
    ./scripts/setup-config.sh

    install_nvm_and_node

    echo ""
    echo "✅ Setup complete! 🎉"
    echo "➡️  Please restart your shell or run 'exec zsh' for changes to take effect."
}

main "$@"
