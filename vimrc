set nocompatible " not vi compatible

""""""""""""""""""""""""
" Pathogen (for VIm <8)
""""""""""""""""""""""""
" execute pathogen#infect()
" execute pathogen#infect('~/.vim/pack/{}/opt/onedark.vim')

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
" intuitive line movement
nnoremap j gj
nnoremap k gk
" tab navigation
nnoremap H gT
nnoremap L gt
nnoremap <C-t>     :tabnew<CR>
"inoremap <C-S-tab> <Esc>:tabprevious<CR>i
"inoremap <C-tab>   <Esc>:tabnext<CR>i
inoremap <C-t>     <Esc>:tabnew<CR>
" Turn on line numbers
set number 
" toggle relative numbering
nnoremap <C-n> :set rnu!<CR> 

set scrolloff=5 " keep cursor roughly centered
set mouse+=nv " allow mouse usage

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
" set cmdheight=2

" Highlight search
set hlsearch
" Use <leader> + Enter to turn off highlighting until next search
nnoremap <leader><CR> :noh<CR>

" Incremental searches
set incsearch

" will only be case sensitive if capital letter is used
set ignorecase
set smartcase

" Show matching brackets
set showmatch
set mat=2 " blink for 2/10 of a second when matching brackets

" Add a margin to the left
set foldcolumn=1

" Make the statusline always visible
set laststatus=2
" Get rid of default insert notification (for lightline plugin)
set noshowmode

""""""""""""""""""""""""
" Colors and Fonts
""""""""""""""""""""""""
" Enable file type detection
filetype plugin indent on
" Enable syntax highlighting
if !exists("g:syntax_on")
  syntax enable
endif
" highlight current line, only in active window
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Enable a specific colorscheme (editor and statusline) 
"enable truecolor
if (has("termguicolors"))
  set t_8f=[38;2;%lu;%lu;%lum
  set t_8b=[48;2;%lu;%lu;%lum
  set termguicolors
endif

packadd! onedark.vim
"set background=dark
colorscheme onedark
let g:lightline = {'colorscheme': 'onedark'}

"get rid of weird background color behavior (https://sunaku.github.io/vim-256color-bce.html)
set t_ut=

" Set encoding properly
set encoding=utf-8
set fenc=utf-8
set termencoding=utf-8

""""""""""""""""""""""""
" Text, tab, indents
""""""""""""""""""""""""
" Replace tabs with spaces
set expandtab

" Set tab to display as 2 spaces
set shiftwidth=2
set tabstop=2
set softtabstop=2

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

if has('python')
  map <C-F> :pyf ~/.vim/clang-format.py<cr>
  imap <C-F> <c-o>:pyf ~/.vim/clang-format.py<cr>
elseif has('python3')
  map <C-F> :py3f ~/.vim/clang-format.py<cr>
  imap <C-F> <c-o>:py3f ~/.vim/clang-format.py<cr>
endif

function ClangFormatFile()
  let l:lines="all"
  if has('python')
    pyf ~/.vim/clang-format.py
  elseif has('python3')
    py3f ~/.vim/clang-format.py
  endif
endfunction

if has("autocmd")
  autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee,*.cpp :call CleanExtraSpaces()
  autocmd BufWritePre *.py silent :Black
  autocmd BufWritePre *.c,*.h,*.cpp,*.hpp :call ClangFormatFile()
endif

" save read-only files
cmap w!! w !sudo tee > /dev/null %

" splits
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
set splitbelow
set splitright

" ease of use
nnoremap <CR> :w<CR>
nnoremap <space> :
nnoremap Q @q
"make < > shifts keep selection
vnoremap < <gv
vnoremap > >gv

" paste
set pastetoggle=<F2>

set hidden " allow buffers to be hidden without saving

" save folds on close
" https://vim.fandom.com/wiki/Make_views_automatic
augroup AutoSaveFolds
  autocmd!
  autocmd BufWinLeave *.* mkview
  autocmd BufWinEnter *.* silent! loadview
augroup END

"""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""
" nerdtree
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

" nerdcommenter
nnoremap <C-_> :call NERDComment(0, "toggle")<CR>
vnoremap <C-_> :call NERDComment(0, "toggle")<CR>
