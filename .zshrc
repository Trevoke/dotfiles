PROMPT=$(print "%D %*\n%m:%n %2~ %# ")
fpath=(/usr/local/share/zsh-completions $fpath)
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
