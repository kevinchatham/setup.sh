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
alias nvim="~/.nvim/squashfs-root/AppRun"
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias nvim-config="nvim ~/.config/nvim/init.lua"

alias zsh-config="nvim ~/.zshrc"
alias zsh-spectrum="spectrum_ls"
alias zsh-themes="nvim ~/.oh-my-zsh"

# zsh colors, theme, plugins 
export ZSH="/home/kevin/.oh-my-zsh"
export LS_COLORS="$LS_COLORS:ow=1;33:tw=1;33:"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
# ZSH_THEME="tokyo-night"

# zsh command colors
source $ZSH/oh-my-zsh.sh
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=#61afef
ZSH_HIGHLIGHT_STYLES[alias]=fg=#61afef
ZSH_HIGHLIGHT_STYLES[precommand]=fg=#61afef
ZSH_HIGHLIGHT_STYLES[arg0]=fg=#61afef
ZSH_HIGHLIGHT_STYLES[path]=none

eval "$(starship init zsh)"

# load nvm + nvm bash completion
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# shorthand commit all w messsage + push
function commit_function() {
    git add .
    git commit -a -m "$1"
    git push
}

# TODO - MULTIPLE FLAVORS OF JAVA
# export JAVA_19_HOME=/usr/lib/jvm/java-19-openjdk-amd64/bin/
# export JAVA_17_HOME=/usr/lib/jvm/java-17-openjdk-amd64/bin/
# export JAVA_11_HOME=/usr/lib/jvm/java-11-openjdk-amd64/bin/
# export JAVA_8_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64/bin/
# alias java19="export JAVA_HOME=$JAVA_19_HOME"
# alias java17="export JAVA_HOME=$JAVA_17_HOME"
# alias java11="export JAVA_HOME=$JAVA_11_HOME"
# alias java8="export JAVA_HOME=$JAVA_8_HOME"
# java8 #set default
