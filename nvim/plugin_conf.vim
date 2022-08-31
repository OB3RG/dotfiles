" color schemes
if (has("termguicolors"))
    set termguicolors
endif

syntax enable
colorscheme gruvbox

" Nerdcommenter
let g:NERDCreateEefaultMappings = 1

"" add spaces after comment delimiters by default
let g:NERDSpacesDelims = 1

"" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

"" Align line-wise comment delimiters flush left instead of following code
"" indention
let g:NERDDefaultAlign = 'left'

"" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

"" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

"“ Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

"“ Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

"" for motions
nnoremap <silent> <leader>c} V}:call NERDComment(‘x’, ‘toggle’)<CR>
nnoremap <silent> <leader>c{ V{:call NERDComment(‘x’, ‘toggle’)<CR>


" CoC
let g:coc_global_extensions = [
    \ 'coc-pairs',
    \ 'coc-json',
    \ 'coc-rls',
    \ 'coc-elixir',
    \ 'coc-tsserver',
\]

set signcolumn=yes

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden = 1


" Lightline
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction'
      \ },
      \ }

" FZF
let g:fzf_command_prefix = 'Fzf'
nnoremap <C-p> :FzfGFiles<CR>
nnoremap <C-C> :FzfAg<CR>


" VIM GO
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0

" Automatically import packages on save
let g:go_fmt_command = "goimports"

" Terraform
let g:terraform_align=1
let g:terraform_fmt_on_save=1

" " Elixir
let g:mix_format_on_save = 1
let g:mix_format_silent_errors = 1

" Neoformat
let g:neoformat_try_node_exe = 1
autocmd BufWritePre,TextChanged,InsertLeave *.js Neoformat
autocmd BufWritePre,TextChanged,InsertLeave *.ts,*.tsx Neoformat

