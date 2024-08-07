#number of lines kept in history
export HISTSIZE=10000
# number of lines saved in the history after logout
export SAVEHIST=10000
# location of history
export HISTFILE=~/.zhistory
# append command to history file once executed
setopt inc_append_history

bindkey -e
bindkey '\e[H' beginning-of-line
bindkey '\e[F' end-of-line
bindkey '\e[5~' history-beginning-search-backward
bindkey '\e[6~' history-beginning-search-forward
bindkey '\e[1;3D' emacs-backward-word
bindkey '\e[1;3C' emacs-forward-word
bindkey '\e[3~' delete-char
bindkey '\e[3;3~' delete-word

# Homebrew path
export PATH=~/bin:/usr/local/bin:/usr/local/sbin:$PATH
export PATH=$PATH:/usr/local/share/npm/bin
export PATH="/home/stag/.evm/bin:$PATH"

zstyle ':completion:*' completer _oldlist _expand _complete _ignored _correct _prefix
zstyle ':completion:*' completions 1
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort access
zstyle ':completion:*' format 'Scanning %d'
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd .. directory
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' match-original both
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' menu select=1
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' substitute 1
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle :compinstall filename '~/.zshrc'

# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)

autoload -Uz compinit
compinit

fpath=(/usr/local/share/zsh-completions $fpath)

setopt correct

source ~/bin/zsh/gentoo-prompt
# export TERM=screen-256color
autoload -U colors && colors
PROMPT=$(print "\n%{$fg_no_bold[yellow]%}%D %*%{$reset_color%}\n%F{147}%n%f%{$reset_color%}@%{$fg[green]%}%m%{$reset_color%} %2~ %# ")

source ~/.profile

OS_TYPE=`uname -s`
if [[ $OS_TYPE == 'Linux' ]]; then
    setxkbmap -option 'ctrl:nocaps'
elif [[ $OS_TYPE == 'Darwin' ]]; then
fi

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '%b'

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
RPROMPT=\$vcs_info_msg_0_


alias l="ls"
alias la="ls -a"
alias tmux="tmux -2"
alias g="git status"

LS_VERSION=`man ls -P cat | tail -1 | cut -d' ' -f 1`
if [[  $LS_VERSION == 'GNU' ]]; then
    alias ls="ls --color"
elif [[ $LS_VERSION == 'BSD' ]]; then
    alias ls="ls -G"
fi

unset LS_VERSION
unset OS_TYPE

export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PATH=$HOME/.cask/bin:$PATH

. $HOME/.asdf/asdf.sh
export PATH="$PATH:$HOME/.dotnet/tools/"

export DOCKER_BUILDKIT=1

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/stag/usr/google-cloud-sdk/path.zsh.inc' ]; then . '/home/stag/usr/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/stag/usr/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/stag/usr/google-cloud-sdk/completion.zsh.inc'; fi
fpath+=${ZDOTDIR:-~}/.zsh_functions

export FLYCTL_INSTALL="/home/stag/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"
export PATH="/home/stag/.evm/bin:$PATH"

export PATH="/home/stag/src/vendor/zig-linux-x86_64-0.10.1:$PATH"
export PATH="/opt/cuda/bin:$PATH"

source ~/.shell-secrets
