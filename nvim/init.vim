set nocompatible " disable compatibility to old-time vi
set showmatch " show matching
set ignorecase " case insensitive
set hlsearch " highlight search
set incsearch " incremental search
set tabstop=4 " numberofcolumns occupied by a tab
set softtabstop=4 " see multiple spaces as tabstops so <BS> does the right thing
set expandtab " converts tabs to white space
set shiftwidth=4 " width for autoindents
set autoindent " indent a new line the same amount as the line just typed
set number " add line numbers
set wildmode=longest,list " get bash-like tab completions
set cc=120 " set an 120 column border for good coding style
filetype plugin indent on " allow auto-indenting dependingonfile type
syntax on " syntax highlighting
set mouse=a " enable mouse click
set clipboard=unnamedplus " using system clipboard
filetype plugin on
set cursorline " highlight current cursorline
set ttyfast " Speed up scrolling in Vim
set noswapfile " disable creating swap file
set backupdir=~/.cache/nvim " Dir to store backup files
set cmdheight=2
set shortmess+=c
set signcolumn=yes
set hidden
set updatetime=300

source ~/.config/nvim/plugins.vim
source ~/.config/nvim/plugin_conf.vim
source ~/.config/nvim/keybindings.vim
source ~/.config/nvim/extends.vim
