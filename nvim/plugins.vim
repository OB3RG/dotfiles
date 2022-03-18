let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'

if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin(stdpath('data') . '/plugged')
    "Apperance
    Plug 'morhetz/gruvbox'
    Plug 'itchyny/lightline.vim'

    " Language stuff
    Plug 'hashivim/vim-terraform'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'fatih/vim-go', { 'do': ':silent :GoUpdateBinaries'}
    Plug 'sbdchd/neoformat'
    Plug 'rust-lang/rust.vim'

    "" Elixir
    Plug 'elixir-editors/vim-elixir'
    Plug 'mhinz/vim-mix-format'

    "Fuzzy search
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'rking/ag.vim'

    " Misc
    Plug 'scrooloose/nerdcommenter'
    Plug 'scrooloose/nerdtree'
call plug#end()

