" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

" no noises
set belloff=all

" syntax highlighting for lines > 3000 chars
set synmaxcol=0

" reset syntax highlighting
nnoremap <leader>s :syntax sync fromstart<CR>

" tabs and stuff
set shiftwidth=4
set tabstop=4
set expandtab
set autoindent
set list
set listchars=tab:>-

autocmd FileType typescriptreact setlocal shiftwidth=2 tabstop=2 expandtab

" line numbers
set number
set relativenumber
noremap <leader>n :set number! relativenumber!<CR>

" searching
set hlsearch
nnoremap <leader>f :!grep --exclude-dir .git -Irn <cword \| less<CR>

" backup/swap/undo config
call mkdir($HOME . "/.vimtmp", "p")
set backup
set backupdir=~/.vimtmp//,.
set swapfile
set directory=~/.vimtmp//,.
set undofile
set undodir=~/.vimtmp//,.

" run the current file
nnoremap <leader>r :!%:p

" go to cursor position at last close
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" Install vim-plug if not found
if empty(glob($HOME . '/.vim/autoload/plug.vim'))
  silent !curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs
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
Plug 'prabirshrestha/asyncomplete-lsp.vim'
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
    nnoremap <buffer> <expr><c-b> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    "autocmd! BufWritePre *.py,*.js,*.ts,*.jsx,*.tsx,*.go call execute('LspDocumentFormatSync')
    autocmd! BufWritePre *.go,*.sh call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

if !empty(globpath(&rtp, 'colors/alduin.vim'))
    colorscheme alduin
endif

" cheatsheet
"MISC:
"ZZ - save and quit
"
"word-based movement:
"	ge      b	  w				e
"	       <-     <-	 --->			       --->
"	This is-a line, with special/separated/words (and some more). ~
"	   <----- <-----	 -------------------->	       ----->
"	     gE      B			 W			 E
"
"
"positioning the cursor on screen:
"			+---------------------------+
"		H -->	| text sample text	    |
"			| sample text		    |
"			| text sample text	    |
"			| sample text		    |
"		M -->	| text sample text	    |
"			| sample text		    |
"			| text sample text	    |
"			| sample text		    |
"		L -->	| text sample text	    |
"			+---------------------------+
"
"Hints: "H" stands for Home, "M" for Middle and "L" for Last.  Alternatively,
""H" for High, "M" for Middle and "L" for Low.
"
"scrolling:
"CTRL-E - down one line
"CTRL-Y - up one line
"CTRL-D - down half a page
"CTRL-U - up half a page
"CTRL-F - down a full page
"CTRL-B - back a full page
"
"moving the screen relative to the cursor:
"zz - scroll the screen so that the cursor is positioned in the middle of the screen
"zt - *** top of the screen
"zb - *** bottom of the screen
"
"searching for characters in a line:
"f<char> - go to next occurrence of character
"F<char> - go to previous occurrence of character
"t<char> - go to character previous to next occurrence of searched char
"T<char> - go to character previous to previous occurrence of searched char
"; - repeat last
", - repeat reverse last
"
"searching for characters in file:
"set ignorecase
"set noignorecase
"
"searching for text:
"* - search for the next occurrence of the word
"# - *** previous occurrence
"g* - *** next occurrence but without \<\>
"g# - *** previous ***
"set no/wrapscan - enable/disable searching passed the bottom of the file back around to the top, and vice versa
"set no/incsearch - enable/disable the display of matches while you are still typing your search
"set hlsearch/nohlsearch - disable/enable the editor to highlight matching text
"hlsearch/nohlsearch - disable/enable highlighting for the moment, but not for future searches
"
"marks and jumps:
"moving with something other than hjkl and wbe is considered a jump.
":jumps - list positions youve jumped to
":marks - list marks
"	'	The cursor position before doing a jump
"	"	The cursor position when last editing the file
"	[	Start of the last change
"	]	End of the last change
"m<letter> - set a named mark
"`<letter> - go to a named mark
"'<letter> - go to a named mark at the beginning of the line
"`` - go back and forth between current and previous location
"'' - ****** at beginning of line
"CTRL-O - go to older locations
"CTRL-I - go to newer locations
"	Note:
"	CTRL-I is the same as <Tab>.
