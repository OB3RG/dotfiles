" #Plugins
" vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" Liniting and Code Formatting
Plug 'w0rp/ale'

" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries'}

" Elixir
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'

" Javascript / Typescript
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'jparise/vim-graphql'        " GraphQL syntax

" Git
Plug 'tpope/vim-fugitive'

" Syntax Highlightning
Plug 'sheerun/vim-polyglot'
Plug 'Quramy/vim-js-pretty-template'
Plug 'hashivim/vim-terraform'

" Appearance and themes
" Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-buftabline'

" Autocompletion & Intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release', 'tag': '*', 'do': { -> coc#util#install()}}
" CocInstall coc-json coc-tsserver
" CocInstall coc-elixir
" CocInstall coc-json

" Fuzzy Search
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'rking/ag.vim'

" Utilities
Plug 'scrooloose/nerdtree'
Plug 'Yggdroot/indentLine'
Plug 'lfv89/vim-interestingwords'
Plug 'scrooloose/nerdcommenter'
Plug 'lilydjwg/colorizer'


call plug#end()
