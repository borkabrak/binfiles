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


# contains(): is $candidate a member of $array?
#  DOES NOT CURRENTLY SEEM TO WORK RIGHT -- FIXME
#function contains(){
#    array=$1
#    candidate=$2
#    return true
#}


# Return 0 iff all the arguments are available commands.
#
# This is intended to be called from shell scripts, to confirm whether the
# given commands exist, and to gracefully handle it when they do not.
#
# Use it like this:
#
#   require command1 command2 || exit
#
# If any of the commands are not found, a message will be printed to that
# effect and the main script exits.
function require() {

    typeset -a missing_dependencies

    # Populate the missing dependencies
    for resource in $@; do
        if [[ -z $(whence $resource) ]]; then
            missing_dependencies+=$resource
        fi
    done

    # Notify of errors
    if [[ $#missing_dependencies > 0 ]]; then
        print "$#missing_dependencies Required dependecies missing:\n\t$missing_dependencies"
        return $#missing_dependencies
    fi

}
