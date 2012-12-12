# number of lines kept in history
export HISTSIZE=10000
# number of lines saved in the history after logout
export SAVEHIST=10000
# location of history
export HISTFILE=~/.zhistory
# append command to history file once executed
setopt inc_append_history

PATH=~/bin:/usr/local/bin:/usr/local/sbin:$PATH

autoload -U compinit && compinit
fpath=(/usr/local/share/zsh-completions $fpath)

autoload -U colors && colors
PROMPT=$(print "\n%{$fg[yellow]%}%D %*%{$reset_color%}\n%{$fg[blue]%}%n%{$reset_color%}@%{$fg[green]%}%m%{$reset_color%} %2~ %# ")

alias ls="ls -G"
alias g="git status"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
