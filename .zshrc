autoload -U compinit
compinit

fpath=(/usr/local/share/zsh-completions $fpath)

alias ls="ls -G"
alias g="git status"

PATH=~/bin:/usr/local/bin:/usr/local/sbin:$PATH
PROMPT=$(print "%D %*\n%m:%n %2~ %# ")
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
