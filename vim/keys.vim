" Change leader key from \ to ,
let mapleader = ","

" turn off search highlights
nnoremap <leader><space> :nohlsearch<CR>

" jj to ESC
imap jj <ESC>

" Navigate tabs
noremap <Leader>o :bn<CR>
noremap <Leader>i :bp<CR>

" Toggle NerdTree
noremap <Leader>f :NERDTreeToggle<Enter>

"Navigation keys
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l

" Console log from insert mode; Puts focus inside parentheses
imap xll console.log()<Esc>==f(a
" Console log from visual mode on next line, puts visual selection inside parentheses
vmap xll yoxll<Esc>p
" Console log from normal mode, inserted on next line with word your on inside parentheses
nmap xll yiwoxll<Esc>p
