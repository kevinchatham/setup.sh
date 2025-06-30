# list hidden
alias lh="ls -a"

# comfort
alias powershell="pwsh"

# shorthand clear / exit
alias c="clear"
alias cls="clear"
alias e="exit"

# npm
alias npr="npm run"
alias npi="npm i"
alias npk="pkill -f node"
export NODE_OPTIONS="--max-old-space-size=8192"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ASP.NET Core
export ASPNETCORE_ENVIRONMENT="Development"

# one word git actions
alias add="git add ."
alias commit=commit_function
alias dif="git diff --color-words"
alias status="git status"

# one word os update / upgrade
alias update="sudo apt update"
alias upgrade="sudo apt update && sudo apt upgrade -y && ~/setup.sh/setup.sh"

# nvim only
alias nvim="~/.nvim/squashfs-root/AppRun"
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias nvim-config="nvim ~/.config/nvim/init.lua"

# zsh
alias zsh-config="nvim ~/.zshrc"
alias zsh-spectrum="spectrum_ls"
alias zsh-themes="nvim ~/.oh-my-zsh"

# zsh colors, theme, plugins
export ZSH="/home/kevin/.oh-my-zsh"
export LS_COLORS="$LS_COLORS:ow=1;33:tw=1;33:"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
# ZSH_THEME="tokyo-night"

# zsh command colors
# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md
# https://github.com/zsh-users/zsh-autosuggestions
source $ZSH/oh-my-zsh.sh
ZSH_HIGHLIGHT_STYLES[path]=none                         # No color for path arguments
ZSH_HIGHLIGHT_STYLES[precommand]=fg=#61afef             # No color for pre-command modifiers
ZSH_HIGHLIGHT_STYLES[arg0]=fg=#61afef                   # Blue color for the first argument (command name)
ZSH_HIGHLIGHT_STYLES[default]=fg=white                  # White color for all other arguments
ZSH_HIGHLIGHT_STYLES[alias]=fg=#61afef                  # Blue color for command aliases
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=#61afef           # Blue color for suffix aliases
ZSH_HIGHLIGHT_STYLES[command]=fg=#61afef                # Blue color for command names
ZSH_HIGHLIGHT_STYLES[function]=fg=#61afef               # Blue color for function names
ZSH_HIGHLIGHT_STYLES[builtin]=fg=#61afef                # Blue color for built-in commands
ZSH_HIGHLIGHT_STYLES[back-quoted-command]=fg=#98c379    # Light green color for back-quoted commands
ZSH_HIGHLIGHT_STYLES[command-substitution]=fg=#98c379   # Light green color for command substitutions
ZSH_HIGHLIGHT_STYLES[command-line-argument]=fg=white    # White color for command line arguments
ZSH_HIGHLIGHT_STYLES[pattern]=fg=#e06c75                # Red color for patterns
ZSH_HIGHLIGHT_STYLES[variable]=fg=#d19a66               # Orange color for variables
ZSH_HIGHLIGHT_STYLES[environment-variable]=fg=#d19a66   # Orange color for environment variables
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=#c678dd      # Purple color for history expansions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#111"               # Dark gray color for autocomplete suggestions

eval "$(starship init zsh)"

# shorthand commit all w messsage + push
function commit_function() {
    git add .
    git commit -a -m "$1"
    git push
}

# flyctl
export FLYCTL_INSTALL="/home/kevin/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"
alias fly="flyctl"

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
