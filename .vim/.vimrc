
""""""""""""""""""""""""
" General
""""""""""""""""""""""""
" Update file if it is changed outside of Vim
set autoread

" Set the mapleader for key mappings
let mapleader=","
let g:mapleader=","

" Fast file saving
nmap <leader>w :w!<cr>
" Fast vimrc reloading
nmap <leader>s :source ~/.vimrc<cr>

" History
set hidden
set history=100
""""""""""""""""""""""""
" VIM User Interface
""""""""""""""""""""""""
" Turn on line numbers
set number

" Color a column to control line length
set colorcolumn=100

" Show currently-typed command
set showcmd

" Set proper languages
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the wild menu
set wildmenu
" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if (has("win16") || has("win32"))
  set wildignore+=.git\*,.hg\*,.svn\*
else
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_STORE
endif

" Show current position
set ruler

" Height of command bar
set cmdheight=2

" Highlight search
set hlsearch
" Use <leader> + Enter to turn off highlighting until next search
nnoremap <leader><CR> :noh<CR>

" Incremental searches
set incsearch

" Show matching brackets
set showmatch
set mat=2 " blink for 2/10 of a second when matching brackets

" Add a margin to the left
set foldcolumn=1

""""""""""""""""""""""""
" Colors and Fonts
""""""""""""""""""""""""
" Enable file type detection
filetype on
" Enable syntax highlighting
if !exists("g:syntax_on")
  syntax enable
endif
" Enable a specific theme
colorscheme Tomorrow-Night
" Set encoding properly
set encoding=utf-8
set fenc=utf-8
set termencoding=utf-8

""""""""""""""""""""""""
" Text, tab, indents
""""""""""""""""""""""""
" Use correct indent file for filetype
filetype indent on

" Replace tabs with spaces
set expandtab

" Set tab to display as 2 spaces
set shiftwidth=2
set tabstop=2

" Indenting
set autoindent " Copy current indent level over to next line
set smartindent " More intelligent indenting for C

"""""""""""""""""""""""
" Other
"""""""""""""""""""""""
fun! CleanExtraSpaces()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  silent! %s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfun

if has("autocmd")
  autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee,*.cpp :call CleanExtraSpaces()
endif

