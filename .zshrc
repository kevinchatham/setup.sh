SH_DISABLE_COMPFIX=true # prevents insecure plugin folder warnings with oh-my-zsh

export ZSH="/home/kevin/.oh-my-zsh"
export LS_COLORS="$LS_COLORS:ow=1;33:tw=1;33:" # adjusts folder colors in 'ls'

export PATH="/snap/bin:$PATH"

export PATH=/opt/apache-maven-3.8.4/bin:${PATH}

ZSH_THEME="tokyo-night"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=#86e1fc#
ZSH_HIGHLIGHT_STYLES[alias]=fg=#86e1fc
ZSH_HIGHLIGHT_STYLES[precommand]=fg=#86e1fc
ZSH_HIGHLIGHT_STYLES[arg0]=fg=#86e1fc
ZSH_HIGHLIGHT_STYLES[path]=none

alias lh="ls -a"
alias e="exit"
alias cls="clear"
alias c="clear"
alias update="sudo apt update"
alias upgrade="sudo apt update && sudo apt upgrade -y"
alias powershell="pwsh"
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias vi-config="nvim ~/.config/nvim/init.lua"
alias zsh-spectrum="spectrum_ls"
alias zsh-config="code ~/.zshrc"
alias zsh-themes="code ~/.oh-my-zsh"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export JAVA_19_HOME=/usr/lib/jvm/java-19-openjdk-amd64/bin/
export JAVA_17_HOME=/usr/lib/jvm/java-17-openjdk-amd64/bin/
export JAVA_11_HOME=/usr/lib/jvm/java-11-openjdk-amd64/bin/
export JAVA_8_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64/bin/

alias java19="export JAVA_HOME=$JAVA_19_HOME"
alias java17="export JAVA_HOME=$JAVA_17_HOME"
alias java11="export JAVA_HOME=$JAVA_11_HOME"
alias java8="export JAVA_HOME=$JAVA_8_HOME"

java8 #set default

function commit() {
    git add .
    git commit -a -m "$1"
    git push
}

