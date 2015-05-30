#
# .zshrc
# Sourced by zsh on LOGIN and INTERACTIVE shells
#

	#Autoload programmable completion
	autoload -U compinit
	compinit -u

	#Makes available a set of default prompts accessible with the 'prompt' command
	autoload -U promptinit
	promptinit

	#Use vi mode command line editing
	setopt vi

        # By default, zsh's vi mode emulates.. vi (not vim).  This means no
        # multi-level undo/redo.  These lines fix that.
        #  (WARNING: ^R defaults to 'redisplay'.  Just in case you actually
        #  need that..)
        bindkey -a u undo
        bindkey -a '^R' redo

        # Easier command mode
        bindkey ii vi-cmd-mode

	#Don't logout on ^D
	setopt ignoreeof

	#Don't append duplicate commands to command history
	setopt histignoredups

	#Type the name of a directory to change into it
	setopt autocd

	#To see the directory stack, type 'dirs -v'
	#To go to the 'n'th directory, type '~n'
	#Push directory onto directory stack when you change into it
	setopt autopushd

	#Don't push consecutive duplicate directories onto the stack
	setopt pushdignoredups

	#Save space on completion lists by printing variable-width columns
	setopt listpacked

	#In completion lists, matches are listed across and then down, instead of vice versa
	setopt listrowsfirst 

	#Use trailing symbols identifying the type of each file
	#('/' => directory, '*' => executable, etc.)
	#setopt nolisttypes

	#Don't store the 'history' command itself in the history
	setopt histnostore

	#When invoking a command from the history, display it first without executing it
	setopt histverify

	#Try to correct the spelling of commands
	#setopt correct

	#Try to correct the spelling of all arguments in a line
	#setopt correctall	

	#List jobs in the long format by default
	setopt longlistjobs

	#Report the status of background jobs immediately, instead of waiting until
	# just before printing a prompt
	setopt notify

	#Allow double apostrophes to be replaced with a single apostrophe within an apostrophe quoted string	
	setopt rcquotes

	#Do not require a leading '.' in a filename to be matched explicitly
	setopt globdots

	#Add a slash instead of a space when autocompleting a directory name
	setopt auto_param_slash

	#Alright, there's a lot going on with prompt colors in zsh.  Quick and dirty course:
	#
	#	-Color sequences are enabled in a string by quoting the whole thing in the dollar-quote ($'') construct.
	#
	#	-A color is 'turned on' with the sequence:
	#
	#		\e[x;yym
	#
	#	 	where 'x' is a modifier (1 means 'bright' or 'bold', while '0' means normal)
	#	 	and 'yy' is a color code (31 is red, 32 is green, and 34 is blue, for example)
	#		and the 'm' is a literal character 'm'.
	#		(The above is not _exactly_ how it works, but is accurate enough for here)
	#
	#	-Be warned: The shell seems to consider the color escape characters when calculating the length
    #		of the prompt.
	#		This will make the cursor do some crazy things in some situations, especially upon completion
    #		attempts.
	#		To avoid this, surround the entire color escape sequence above (from the slash to the m) with 
	#		curly braces.  
	#		BUT, to make sure those curly braces are not printed literally by the shell, preface
	#		each one with zsh's escape character, '%'
	#
	#		Like this:
	#			%{<color escape>%}
	#
	#Also, while an argument can be made that as an environment variable, PROMPT belongs in .zshenv,
	# I can't think of a case in which a non-interactive shell would need a prompt.	
    # (More info on ANSI escape sequences: http://en.wikipedia.org/wiki/ANSI_escape_code )
	
	#This uncolored prompt looks like:
	#	'[user@host]~> '
	#PROMPT=$'[%n@%m]%~> '
	
	#This prompt looks like:
	#
	#	'[user@host]~> '
	#	
	#	but with some groovy colors setting elements apart
	#
	#PROMPT=$'%{\e[0;32m%}[%n@%{\e[1;31m%}%m%{\e[0;32m%}]%{\e[1;34m%}%~%{\e[1;32m%}> %{\e[0m%}'

	#Super psycho sexy prompt developed by a shadowy clan of NASA-trained space monkeys:
	#PROMPT=$'%{\e[0;32m%}[%{\e[1;32m%}%n@%{\e[1;31m%}%m%{\e[1;32m%}:zsh(%?)%{\e[1;32m%}]%{\e[0;34m%}%~%{\e[1;32m%}> %{\e[0m%}'
	#PROMPT=$'%{\e[1;32m%}[%{\e[1;32m%}%n@%{\e[1;34m%}%m%{\e[1;32m%}:zsh(%?)%{\e[1;32m%}]%{\e[1;34m%}%~%{\e[1;32m%}> %{\e[0m%}'
	PROMPT=$'%{\e[1;32m%}%n@%m%{\e[m%}:%{\e[1;34m%}%~%{\e[m%}> '
	export PROMPT

    #alias ss='byobu-screen'
    alias ss='tmux attach || tmux'
	alias hh='history'
    alias c='clear'  #Am I really going to need to clear the screen this quickly?
	alias ls='ls --color=auto -h'
	alias ll="ls -l"
	alias rot13="tr a-zA-Z n-za-mN-ZA-M"
	alias r="fc -s"	#Repeat last command
	alias datestamp='perl -e "use POSIX;print strftime(qq(%D),localtime).qq(\n)"' #Write current mm/dd/yyyy
	alias less='less -R'	#Allow less to properly handle ANSI color codes
	alias rm='rm -i'
	alias l='ls'
	alias lisp='clisp -q'
    
    #What package provides a particular file?
    alias whatprovides='apt-file search -x'
    
	#Don't use '_' as end-of-string marker in xargs
	alias xargs='xargs -e' 

	# For easier left-hand typing, use CapsLock to make the left half of the keyboard a 'mirror' of the right half. 
	# More info at [http://blag.xkcd.com/2007/08/14/mirrorboard-a-one-handed-keyboard-layout-for-the-lazy/]
	alias mirrorboard='xkbcomp ~/bin/mirrorboard.xkb $DISPLAY 2>/dev/null'

	# Wise cow
	alias cowfortune='fortune -a | cowsay -n'

	alias e='vim'
	#alias nethack='telnet nethack.alt.org'
	alias a2r='sudo apache2ctl restart'	#Quick Apache restart
	alias suso='ssh jcarter@jcarter.suso.org'	#Connect to suso, properly
	alias cd..='cd ..'
    alias path='echo $PATH'
    alias pingle='ping www.google.com'
	#Be careful with dangerous commands
	alias mv='mv -i'
	alias cp='cp -i'
	alias rm='rm -i'

	# This makes zsh completion aware of newly installed programs without restarting
	alias repath='export PATH=$PATH'

    # For fun
    alias please='sudo'
    alias dammit,='sudo'
    alias xyzzy='echo Nothing happens'
    alias rtfm='man'
	
    # NCM-specific stuff
    source ~/.ncmrc
