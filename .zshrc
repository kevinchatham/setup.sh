ZSH_DISABLE_COMPFIX=true # prevents insecure plugin folder warnings with oh-my-zsh

export ZSH="/home/kevin/.oh-my-zsh"
export LS_COLORS="$LS_COLORS:ow=1;33:tw=1;33:" # adjusts folder colors in 'ls'

export PATH="/snap/bin:$PATH"

export PATH=/opt/apache-maven-3.8.4/bin:${PATH}

ZSH_THEME="calm"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=blue
ZSH_HIGHLIGHT_STYLES[alias]=fg=blue
ZSH_HIGHLIGHT_STYLES[precommand]=fg=blue
ZSH_HIGHLIGHT_STYLES[arg0]=fg=blue
ZSH_HIGHLIGHT_STYLES[path]=none

alias e="exit"
alias cls="clear"
alias c="clear"
alias update="sudo apt update"
alias upgrade="sudo apt update && sudo apt upgrade -y"
alias powershell="pwsh"
alias zsh-spectrum="spectrum_ls"
alias zsh-config="code ~/.zshrc"
alias zsh-themes="code ~/.oh-my-zsh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
