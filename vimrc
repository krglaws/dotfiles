" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

" tabs and stuff
set shiftwidth=4
set tabstop=4
set expandtab
set autoindent
autocmd FileType typescriptreact setlocal shiftwidth=2 softtabstop=2 expandtab

" line numbers
set number
set relativenumber

" searching
set hlsearch

" backup/swap/undo config
call mkdir("~/.vimtmp", "p")
set backup
set backupdir=~/.vimtmp//,.
set swapfile
set directory=~/.vimtmp//,.
set undofile
set undodir=~/.vimtmp//,.

" syntax highlighting for lines > 3000 chars
set synmaxcol=0

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()

Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'alessandroyorba/alduin'

call plug#end()

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gi <plug>(lsp-peek-implementation)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gu <plug>(lsp-type-definition)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.py,*.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

colorscheme alduin
