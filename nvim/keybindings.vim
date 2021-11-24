" Map leader to comma
let mapleader = ","

" remap jj to esc
:inoremap jj <Esc>

" Move between panes to l/b/t/r
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Move split panes to l/b/t/r
nnoremap <A-h> <C-W>H
nnoremap <A-j> <C-W>J
nnoremap <A-k> <C-W>K
nnoremap <A-l> <C-W>L


" NERDTree
nnoremap <Leader>f :NERDTreeToggle<Enter>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>

" Fzf
nnoremap <C-p> :FzfGFiles<CR>
nnoremap <C-C> :FzfAg<CR>
nnoremap <C-b> :FzfBuffers<CR>

" Misc
nnoremap <Leader>w <C-w>q

"Clear search highlight
nnoremap <Leader><Space> :noh<CR>
