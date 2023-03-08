# Development Environment Setup 

This repository automates the setup of my Debian based devleopment environment. It installs all necessary dependencies and software packages, including Zsh plugins and command-line tools like Git, Nvim config and theme, NVM, PowerShell, .NET, Fira Code, Zsh config and theme, Terraform, AZ CLI, etc. 

To pair with the primary setup script there are additional scripts for backing up and restoring configuration files.

## Quick Start

1. Clone and run `setup.sh`

    ```bash
    sudo apt install curl -y
    curl https://kevinc.design/launch.sh | sh
    ```

    - Enter default input / password when prompted.

    - You will be prompted to configure `zsh`. Use the default options / `y` and `exit` when dropped into the new shell. Everything should continue normally after that.

## Aliases

```bash
# list hidden
alias lh="ls -a"

# comfort
alias powershell="pwsh"

# shorthand clear / exit
alias c="clear"
alias cls="clear"
alias e="exit"

# one word git actions
alias add="git add ."
alias commit=commit_function
alias dif="git diff --color-words"
alias status="git status"

# one word os update / upgrade
alias update="sudo apt update"
alias upgrade="sudo apt update && sudo apt upgrade -y"

# nvim only
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias nvim-config="nvim ~/.config/nvim/init.lua"

# zsh config, colors, and themes
alias zsh-config="nvim ~/.zshrc"
alias zsh-spectrum="spectrum_ls"
alias zsh-themes="nvim ~/.oh-my-zsh"
```

## Neovim Screenshot

![nvim](images/nvim.png)

## ZSH Screenshot
![zsh](images/zsh.png)
