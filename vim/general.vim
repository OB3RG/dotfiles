filetype off

filetype plugin indent on

syntax enable

" terminal colors and font
set guifont=Fira\ Code:h18
set encoding=utf-8
set t_Co=256
set term=screen-256color
set termencoding=utf-8

" dont conceale quotes in JSON
let g:vim_json_syntax_conceal = 0

" Enable JSX syntax highlighting in .js files
let g:jsx_ext_required = 0

" More natural split opening.
set splitbelow
set splitright

" Tabs and Spaces
set expandtab " On pressing tab, insert 2 spaces
set tabstop=2 " show existing tab with 2 spaces width
set softtabstop=2
set shiftwidth=2 " when indenting with '>', use 2 spaces width

set number " Show line numbers
set noswapfile " No swap file
set nobackup
set nowritebackup

set textwidth=120
set formatoptions+=t
set colorcolumn=+1
set lazyredraw

" Search all subfolders
set path+=**

" Display matching files on tab complete
set wildmenu

" Ignore node_modules and images from search results
set wildignore+=**/node_modules/**,**/dist/**,**_site/**,*.swp,*.png,*.jpg,*.gif,*.webp,*.jpeg,*.map

" Use the system register for all cut yank and paste operations
set clipboard=unnamedplus

" show number
set number

" accessibility
set list
set listchars=tab:→→,space:.
highlight clear ALEErrorSign
highlight clear ALEWarningSign
hi comment cterm=bold ctermfg=243

" Strip trailing whitespace from all files
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\s\+$//e
