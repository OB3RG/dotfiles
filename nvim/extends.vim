function TrimWhitespace()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre * :call TrimWhitespace()
nnoremap <F5> :call TrimWhitespace()<CR>
