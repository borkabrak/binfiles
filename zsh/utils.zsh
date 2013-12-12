# vim:ft=zsh

# Utility functions for shell scripting

# COLORS
#   (More: `man tput`, `man terminfo`)
########

NORMAL=$(tput sgr0)
GREEN=$(tput setaf 2; tput bold)
YELLOW=$(tput setaf 3)
RED=$(tput setaf 1)
BLUE=$(tput setaf 4)

function blue() {
    echo -e "$BLUE$*$NORMAL"
}

function red() {
    echo -e "$RED$*$NORMAL"
}

function green() {
    echo -e "$GREEN$*$NORMAL"
}

function yellow() {
    echo -e "$YELLOW$*$NORMAL"
}


# echo text only if $DEBUG is set
function debug() {
    [[ -n $DEBUG ]] && echo "DEBUG:>>> $*"
}

