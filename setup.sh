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
        curl -sS https://starship.rs/install.sh | sh -s -- -y
    else
        echo "Starship already installed, skipping."
    fi
}

install_oh_my_zsh() {
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "✨ Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    else
        echo "Oh My Zsh already installed, skipping."
    fi
    
    echo "🎨 Setting up Zsh themes..."
    cp ./themes/calm.zsh-theme ~/.oh-my-zsh/themes/calm.zsh-theme
    cp ./themes/tokyo-night.zsh-theme ~/.oh-my-zsh/themes/tokyo-night.zsh-theme
    
    echo "🧩 Installing Zsh plugins..."
    local ZSH_CUSTOM_PLUGINS="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
    if [ ! -d "$ZSH_CUSTOM_PLUGINS/zsh-autosuggestions" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM_PLUGINS/zsh-autosuggestions"
    else
        echo "zsh-autosuggestions already installed, skipping."
    fi

    if [ ! -d "$ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting" ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting"
    else
        echo "zsh-syntax-highlighting already installed, skipping."
    fi
}

install_azure_cli() {
    if ! is_installed az; then
        echo "☁️  Installing Azure CLI..."
        curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
    else
        echo "Azure CLI already installed, skipping."
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
        echo "Dotnet SDK already installed, skipping."
    fi
}

install_powershell() {
    if ! is_installed pwsh; then
        echo "📦 Installing PowerShell..."
        source /etc/os-release

        case "$ID" in
            ubuntu)
                echo "Configuring Microsoft package repository for $PRETTY_NAME to install PowerShell."
                wget -q "https://packages.microsoft.com/config/${ID}/${VERSION_ID}/packages-microsoft-prod.deb" -O packages-microsoft-prod.deb
                sudo dpkg -i packages-microsoft-prod.deb
                rm packages-microsoft-prod.deb
                sudo apt update
                sudo apt install -y powershell
                ;;
            debian)
                echo "Installing PowerShell LTS on Debian by directly downloading the .deb package for your architecture."
                local PWSH_ARCH
                case "$(uname -m)" in
                    "x86_64") PWSH_ARCH="amd64" ;;
                    "aarch64" | "arm64") PWSH_ARCH="arm64" ;;
                    *)
                        echo "Warning: Unsupported architecture for PowerShell ($(uname -m)). Skipping PowerShell installation."
                        return
                        ;;
                esac

                # Per https://learn.microsoft.com/en-us/powershell/scripting/install/install-debian?view=powershell-7.5
                # We will download the LTS package directly from GitHub releases.
                echo "Finding latest PowerShell LTS release..."
                
                local LTS_TAG_WITH_V
                # The aka.ms link redirects to the latest LTS release page.
                # We use -Ls -o /dev/null -w "%{url_effective}" to get the final URL after all redirects.
                local LTS_LOCATION
                LTS_LOCATION=$(curl -Ls -o /dev/null -w "%{url_effective}" "https://aka.ms/powershell-release?tag=lts")
                LTS_TAG_WITH_V=$(basename "$LTS_LOCATION" | tr -d '\r')

                if [[ -z "$LTS_TAG_WITH_V" || "$LTS_TAG_WITH_V" == "lts" ]]; then
                    echo "Error: Could not determine the latest LTS version of PowerShell."
                    echo "Please try installing manually from https://github.com/PowerShell/PowerShell/releases"
                    return
                fi
                
                echo "Finding download URL from GitHub API for tag ${LTS_TAG_WITH_V}..."
                local RELEASE_API_URL="https://api.github.com/repos/PowerShell/PowerShell/releases/tags/${LTS_TAG_WITH_V}"
                
                local DEB_URL
                # Query the API, find the line with the browser_download_url for the correct deb package, and extract the URL.
                DEB_URL=$(curl -s "$RELEASE_API_URL" | grep "browser_download_url" | grep "linux-${PWSH_ARCH}\\.deb\"" | cut -d '"' -f 4 | head -n 1)

                if [[ -z "$DEB_URL" ]]; then
                    echo "Error: Could not find a PowerShell .deb package for architecture '${PWSH_ARCH}' in release ${LTS_TAG_WITH_V}."
                    echo "Please try installing manually from https://github.com/PowerShell/PowerShell/releases"
                    return
                fi
                
                echo "Downloading PowerShell LTS from $DEB_URL"
                wget "$DEB_URL" -O powershell.deb
                sudo dpkg -i powershell.deb
                echo "Installing dependencies..."
                sudo apt-get install -f -y
                rm powershell.deb
                ;;
            *)
                echo "Warning: Unsupported distribution '$ID'. This script only supports Ubuntu and Debian for PowerShell installation."
                echo "Skipping PowerShell installation."
                ;;
        esac
    else
        echo "PowerShell already installed, skipping."
    fi
}

install_terraform() {
    if ! is_installed terraform; then
        echo "📦 Installing Terraform..."
        local TER_ARCH
        case "$(uname -m)" in
            "x86_64") TER_ARCH="amd64" ;;
            "aarch64" | "arm64") TER_ARCH="arm64" ;;
            *)
                echo "Warning: Unsupported architecture for Terraform ($(uname -m)). Skipping Terraform installation."
                return
                ;;
        esac
        
        local TER_VER
        TER_VER=$(curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
        wget "https://releases.hashicorp.com/terraform/${TER_VER}/terraform_${TER_VER}_linux_${TER_ARCH}.zip" -O ~/terraform.zip
        unzip -o ~/terraform.zip -d ~/
        sudo mv ~/terraform /usr/local/bin/
        rm ~/terraform.zip
    else
        echo "Terraform already installed, skipping."
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
        echo "NVM already installed, skipping."
    fi

    # Source nvm script to use it in the current shell
    # shellcheck source=/dev/null
    . "$NVM_DIR/nvm.sh"

    echo "📦 Installing Node.js LTS..."
    nvm install --lts

    echo "📦 Installing latest npm..."
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
