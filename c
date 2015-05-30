#!/usr/bin/env zsh
#
# c - for "see"
#
# If no params, '[c]lear' screen
# If param is given, '[c]at' its contents
#       If it's a file, print its contents to the screen
#       if it's a directory, list what it contains
#
# This is a strange combination of functions, granted, but it suits my whimsy
# at the moment.
#
# -jdc 2014-12-04

if [ $1 ]; then
  if [ -d $1 ]; then
      ls --color -h $@
  else
    cat $@
  fi
else
  clear
fi
