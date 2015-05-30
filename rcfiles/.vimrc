" Vim configuration file
"   Jonathan Carter
"     Some bits gleaned from Brad Moolenaar's example .vimrc file

    " Gotta clean this up..

" When started as "evim", evim.vim will already have done these settings.
    if v:progname =~? "evim"
        finish
    endif
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
    set nocompatible

" allow backspacing over everything in insert mode
    set backspace=indent,eol,start

    set autoindent    " always set autoindenting on

    if has("vms")
        set nobackup    " do not keep a backup file, use versions instead
    else
        set writebackup    " keep a backup file
    endif
    set history=500   " Keep n lines of command line history
    set ruler         " Show the cursor position all the time
    set showcmd       " Display incomplete commands
    set incsearch     " Do incremental searching.
    set nohlsearch    " Do not highlight search terms.
    set ts=4          " Tabs are n spaces.
    set expandtab     " Use multiple spaces instead of tab characters.
    set shiftwidth=4  " Indent/outdent n spaces.
    set shiftround    " Indent/outdent to the next tab stop.
    set laststatus=2  " Always show statusline, even for the only window open.
    set nowrap        " Don't wrap long lines ON THE WINDOW. (This makes the
                        "  display not match the buffer by adding 'Soft' newlines.)
    set scrolloff=3   " Maintain a few lines of context around the cursor
    set ignorecase    " Ignore case by default in search patterns (A pattern can be made case-sensitive 
                        "  individually  by including '\C' anywhere in it.)
    set smartcase     " Engage case-sensitive searching if the pattern contains uppercase characters, even when ignorecase is on

    set hidden      "Allow switching buffers without writing to the file.
                    " NOTE: Setting 'hidden' means you don't have to save your
                    " changes before you view another file, but it also means
                    " vim maintains a swap file for every open buffer - not
                    " just the one currently being viewed.

    "The viminfo setting tells vim what (and how much) to automatically remember
    "between sessions
    " Examples:
    "   'n : save regular marks (a-z) for n files
    "   fn : save global marks (A-Z,0-9).  On or off (default on)
    "   <n : save n lines for each register (default is all)
    "   :n : save n lines in command history
    set viminfo='1000,f1,<500,:100,%

" fillchars = Filler characters:
"
"   item    default    Used for ~
"    stl:c    ' ' or '^'  statusline of the current window
"    stlnc:c  ' ' or '-'  statusline of the non-current windows
"    vert:c  '|'    vertical separators |:vsplit|
"    fold:c  '-'    filling 'foldtext'
"    diff:c  '-'    deleted lines of the 'diff' option
    set fillchars=stl:\ ,stlnc:\ ,vert:\|,fold:-,diff:-

" Standard status line + ascii value of char under the cursor:
" set statusline=%<%f%h%m%r%=%b\ 0x%B\ \ %l,%c%V\ %P

" Custom, tricked-out status line with formatting to keep everything in place
" (Looking at you, bash):
    set statusline=%<%f%h%m%r%=Char:%03b\ %4(0x%02B%)\ \ Pos:%3l/%L,%02c-%02v\ %4P

" Persistent undo!
"   This leaves a slew of 'un~' files with double-dot leading characters.
"   Messy and confusing.  (set undodir is supposed to fix this, but I give up)
"   borkalork
 set undofile
 set undodir=~/.vim/undo
 set undolevels=1000

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
    map Q gq

" Make p in Visual mode replace the selected text with the "" register.
    vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
" vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
    if &t_Co > 2 || has("gui_running")
        syntax on
        "set hlsearch
    endif

  " Compiled with autocmd support?  Are we being sourced twice?
    if has("autocmd") && !exists("autocommands_loaded")

        " If this file is sourced twice, avoid autocmds being evaluated twice
        let autocommands_loaded = 1

        " Enable file type detection.
        " Use the default filetype settings, so that mail gets 'tw' set to 72,
        " 'cindent' is on in C files, etc.
        " Also load indent files, to automatically do language-dependent indenting.
        filetype plugin indent on

        " For all text files set 'textwidth' to 78 characters.
        autocmd FileType text setlocal textwidth=78

        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

        "Save the current session on shutdown
        autocmd VimLeave * mksession! ~/.shutdown_session.vim

        "Automatically load the default session on startup - may conflict with
        " filenames passed in on command line.
        "
        " autocmd VimEnter source ~/.default_session.vim
        "
        "   (find a way to do this conditionally only when no files are being opened?)
        "
        "   Until then, use the F7 mapping, defined above
        "
        "   Two ways to do this, anyway -- autocmd and just straight sourcing
        "   the file from here in the startup script

    endif " has("autocmd")

" VIM FILE EXPLORER SETTINGS

    " split new windows vertically (only from file explorer
    let g:explVertical=1   
    
    " place new vertical windows to the right of the explorer window
    let g:explSplitRight=1
    
    " Make sure the explorer window starts out on the left
    let g:explStartRight=0
    
    " Set the colorscheme 
    "  (I would really like to figure out how to have this be 
    "   'evening' in the evening, and 'default' otherwise)
    " colorscheme adaryn
    " colorscheme evening
    " colorscheme lilac    
    " colorscheme darkblue
    " colorscheme dante
    colorscheme delek
    
    "highlight clear Comment    "Undo highlighting (in this case, underline) for comments

    "Enable/disable mouse
    "set mouse=a
    set mouse=""
    
    "Enable in-vim manpage lookups (":Man <pagename>")
    runtime! ftplugin/man.vim

    "Enable extended % matching (if, else, XML tags, etc.)
    runtime! macros/matchit.vim
 
"SESSION HANDLING
    "F5/F6 keys manipulate a 'manual' session - different than 
    " the 'default' one that happens on startup and shutdown.
    
    " use F5 to save the session
    map <F5> :mksession! ~/.manual_session.vim<CR>
    " use F6 to restore the saved session
    map <F6> :source ~/.manual_session.vim<CR>
    
    "Use F7 to load the session saved on shutdown
    " This puts vim in the same state as when you last closed it!
    map <F7> :source ~/.shutdown_session.vim<CR>
    
" OTHER MAPPED COMMANDS

    "Switch ` and '
    "  ' is easier to type, and moves the cursor to the column as well as the
    "  line of the given mark
    nnoremap ` '
    nnoremap ' `

    "Use the command window
    
    "for commands
    " map : q:i

    "for searches
    "map / q/i

    "for backward searches
    "map ? q?i

    set cmdwinheight=1  "not too tall, mind you.  I values me screen space.  

    "Use <F2> to open the file browser
    " map <F2> :Vexplore<CR>

    " Here's a better file browser plugin I found on vim.org
    nmap <F2> :NERDTree<CR>

    "An easier way to go to normal mode from insert mode.
    " How often do you type two 'i's? To do so anyway, just wait a second between keystrokes
    imap ii <Esc>
    imap II <Esc>

    " Fix a sudden weird error - the backspace key started to print ^?
    imap  <BS>

    " Hit enter in normal mode to create an empty line under the current one
    "nnoremap <CR> mpo<ESC> 

    "'MatchParen' automatically highlights parentheses.  Slows things down
    "quite a bit, too.
    " :let loaded_matchparen = 1

    " Execute the current file as a command to the system
    " Maybe a bit dangerous..
    " map <F4> <ESC>:!./%
    
    " Groovy command that might cause problems if tmux not installed.
    " Check .vim/doc/vimux.txt for more info
    noremap <F3> :VimuxRunCommand<CR>

"========================================================================"
    " automatically reload files that have changed
    set autoread

    let mapleader=","
    let g:mapleader=","
    nmap <leader>w :w!<cr>

    set wildmenu
    
    set whichwrap+=h,l
    
    set smarttab

    set smartindent

