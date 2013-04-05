source ~/bin/bash/colors.sh
source ~/bin/bash/git-completion.sh

alias ls="ls -G"
alias la="ls -a"
alias ll="ls -lh"
alias lal="ll -a"
alias g="git status"

# Erase duplicates in history
export HISTCONTROL=erasedups
# Store 10k history entries
export HISTSIZE=10000
# Append to the history file when exiting instead of overwriting it
shopt -s histappend

function relative_time_since_last_commit {
    last_commit=`git log --pretty=format:'%ar' -1`
    echo ${last_commit}
}

function format_unit {
    local UNIT=$1
    case "$UNIT" in
        seconds)    UNIT="s"    ;;
        minutes)    UNIT="m"    ;;
        hours)      UNIT="h"    ;;
        days)       UNIT="d"    ;;
        weeks)      UNIT="w"    ;;
        months)     UNIT="mo"   ;;
        years)      UNIT="yr"   ;;
        *);;
    esac
    echo ${UNIT}
}

function color_based_on_unit {
    local UNIT=$1
    if [ "$UNIT" == "s" ] || [ "$UNIT" == "m" ]; then
        local COLOR=${TXTBLU}
    elif [ "$UNIT" == "h" ]; then
        local COLOR=${TXTYLW}
    else
        local COLOR=${TXTRED}
    fi
    echo ${COLOR}
}

srb_git_prompt() {
    local g="$(__gitdir)"
    if [ -n "$g" ]; then
        local SINCE_LAST_COMMIT=$(relative_time_since_last_commit)
        SINCE_LAST_COMMIT=(${SINCE_LAST_COMMIT// / })
        local VALUE=${SINCE_LAST_COMMIT[0]}
        local UNIT=$(format_unit ${SINCE_LAST_COMMIT[1]/,/})

        # for old projects, git reports years and months
        if [ ${SINCE_LAST_COMMIT[2]} != "ago" ]; then
            local EXTRA_VALUE=${SINCE_LAST_COMMIT[2]}
            local EXTRA_UNIT=$(format_unit ${SINCE_LAST_COMMIT[3]/,/})
        fi

        local COLOR=$(color_based_on_unit $UNIT)
        local DELTA="${VALUE}${UNIT}${EXTRA_VALUE}${EXTRA_UNIT}"

        # The __git_ps1 function inserts the current git branch where %s is
        echo `__git_ps1 "%s ${COLOR}∆${DELTA}"`
    fi
}

TXTBLK='\e[0;30m' # Black - Regular
TXTRED='\e[0;31m' # Red
TXTGRN='\e[0;32m' # Green
TXTYLW='\e[0;33m' # Yellow
TXTBLU='\e[0;34m' # Blue
TXTPUR='\e[0;35m' # Purple
TXTCYN='\e[0;36m' # Cyan
TXTWHT='\e[0;37m' # White
BLDBLK='\e[1;30m' # Black - Bold
BLDRED='\e[1;31m' # Red
BLDGRN='\e[1;32m' # Green
BLDYLW='\e[1;33m' # Yellow
BLDBLU='\e[1;34m' # Blue
BLDPUR='\e[1;35m' # Purple
BLDCYN='\e[1;36m' # Cyan
BLDWHT='\e[1;37m' # White
UNDBLK='\e[4;30m' # Black - Underline
UNDRED='\e[4;31m' # Red
UNDGRN='\e[4;32m' # Green
UNDYLW='\e[4;33m' # Yellow
UNDBLU='\e[4;34m' # Blue
UNDPUR='\e[4;35m' # Purple
UNDCYN='\e[4;36m' # Cyan
UNDWHT='\e[4;37m' # White
BAKBLK='\e[40m'   # Black - Background
BAKRED='\e[41m'   # Red
BAKGRN='\e[42m'   # Green
BAKYLW='\e[43m'   # Yellow
BAKBLU='\e[44m'   # Blue
BAKPUR='\e[45m'   # Purple
BAKCYN='\e[46m'   # Cyan
BAKWHT='\e[47m'   # White
TXTRST='\e[0m'    # Text Reset

PS1="\[$BLDBLK\]\n\u:\w \[$TXTBLU\](\$(srb_git_prompt)\[$TXTBLU\])\[$TXTRST\] \n→ "

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
source ~/.profile
source ~/.bashrc

setxkbmap -option 'ctrl:nocaps'
