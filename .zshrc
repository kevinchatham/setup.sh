ZSH_DISABLE_COMPFIX=true # prevents insecure plugin folder warnings with oh-my-zsh

export ZSH="/home/kevin/.oh-my-zsh"
export LS_COLORS="$LS_COLORS:ow=1;33:tw=1;33:" # adjusts folder colors in 'ls'

export PATH="/snap/bin:$PATH"

export PATH=/opt/apache-maven-3.8.4/bin:${PATH}

lazynvm() {
  unset -f nvm node npm
  export NVM_DIR=~/.nvm
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
}

nvm() {
  lazynvm 
  nvm $@
}

node() {
  lazynvm
  node $@
}

npm() {
  lazynvm
  npm $@
}

ZSH_THEME="calm"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# ZSH_HIGHLIGHT_STYLES[unknown-token]='none'
# ZSH_HIGHLIGHT_STYLES[reserved-word]='none'
# ZSH_HIGHLIGHT_STYLES[alias]='none'
# ZSH_HIGHLIGHT_STYLES[suffix-alias]='none'
# ZSH_HIGHLIGHT_STYLES[global-alias]='none'
# ZSH_HIGHLIGHT_STYLES[builtin]='none'
# ZSH_HIGHLIGHT_STYLES[function]='none'
# ZSH_HIGHLIGHT_STYLES[command]='none'
# ZSH_HIGHLIGHT_STYLES[precommand]='none'
# ZSH_HIGHLIGHT_STYLES[commandseparator]='none'
# ZSH_HIGHLIGHT_STYLES[hashed-command]='none'
# ZSH_HIGHLIGHT_STYLES[autodirectory]='none'
# ZSH_HIGHLIGHT_STYLES[path]='none'
# ZSH_HIGHLIGHT_STYLES[path_pathseparator]='none'
# ZSH_HIGHLIGHT_STYLES[path_prefix]='none'
# ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='none'
# ZSH_HIGHLIGHT_STYLES[globbing]='none'
# ZSH_HIGHLIGHT_STYLES[history-expansion]='none'
# ZSH_HIGHLIGHT_STYLES[command-substitution]='none'
# ZSH_HIGHLIGHT_STYLES[command-substitution-unquoted]='none'
# ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]='none'
# ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='none'
# ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]='none'
# ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]='none'
# ZSH_HIGHLIGHT_STYLES[process-substitution]='none'
# ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='none'
# ZSH_HIGHLIGHT_STYLES[arithmetic-expansion]='none'
# ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='none'
# ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='none'
# ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='none'
# ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]='none'
# ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='none'
# ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='none'
# ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]='none'
# ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='none'
# ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]='none'
# ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='none'
# ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]='none'
# ZSH_HIGHLIGHT_STYLES[rc-quote]='none'
# ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='none'
# ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='none'
# ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='none'
# ZSH_HIGHLIGHT_STYLES[assign]='none'
# ZSH_HIGHLIGHT_STYLES[redirection]='none'
# ZSH_HIGHLIGHT_STYLES[comment]='none'
# ZSH_HIGHLIGHT_STYLES[comment]='none'
# ZSH_HIGHLIGHT_STYLES[named-fd]='none'
# ZSH_HIGHLIGHT_STYLES[numeric-fd]='none'
# ZSH_HIGHLIGHT_STYLES[arg0]='none'
# ZSH_HIGHLIGHT_STYLES[default]='none'

ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=blue
ZSH_HIGHLIGHT_STYLES[alias]=fg=blue
ZSH_HIGHLIGHT_STYLES[precommand]=fg=blue
ZSH_HIGHLIGHT_STYLES[arg0]=fg=blue
ZSH_HIGHLIGHT_STYLES[path]=none

alias desktop="ssh kevin@desktop.local"
alias laptop="ssh kevin@laptop.local"
alias living-room="ssh kevin@living-room.local"
alias win10="ssh kevin@win10.local"
alias e="exit"
alias cls="clear"
alias c="clear"
alias update="sudo apt update"
alias upgrade="sudo apt update && sudo apt upgrade -y"
alias powershell="pwsh"
alias zsh-spectrum="spectrum_ls"
alias zsh-config="code ~/.zshrc"
alias zsh-themes="code ~/.oh-my-zsh"