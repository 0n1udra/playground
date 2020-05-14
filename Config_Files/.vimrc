"Debian Root Vim File
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-airline/vim-airline'
Plugin 'jacoborus/tender.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" Put your non-Plugin stuff after this line

set autoread " reload file if changed exterally
set report=0


" ===== UI
colorscheme tender
set term=xterm-256color
set t_ut=

set number " Turn's on number
"set relativenumber
set numberwidth=1 " Set number gutter width
set expandtab " Use spaces instead of tabs. Tab is just 4 spaces now
set tabstop=4
set shiftwidth=4 
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:·
set list

set tabstop=4 shiftwidth=4 expandtab " Set spaces (Spaces > Tabs don't @ me!
set backspace=indent,eol,start " backspace over everything in insert mode

set showmode " Shows current mode
set title " Show file name
set laststatus=2
set modeline " Disabled mode line, for security reasons mostly

highlight ColorColumn ctermbg=grey
call matchadd('ColorColumn', '\%81v', 100) " Only shows grey column bar if line text is breaking 80 char. for ex here :)

set nowrapscan " This is so searching doesn't wrap around and continue. When reach EOF it'll stop
set cursorline " Shows a line under current line
set wildmenu " Helpful autocomplete menu
set lazyredraw " Faster macros
set showmatch " Show matching () [] {}
set hlsearch " Highlights search
set incsearch " Search while typing
" Stops search highlihting with shorcut , Space
"
" ===== Editing, Syntax, Spelling, Highlight
syntax on " Eables syntax highlighting
if (has("termguicolors"))
 set termguicolors
endif

set encoding=utf-8 nobomb   " BOM often causes trouble, UTF-8 is awsum.
set spelllang=en_us         " spell checking
set spell

set foldenable " Allows folding
set foldlevelstart=10
set foldnestmax=10 " Max folding nest level
set foldmethod=indent " Fold according to indentation
nnoremap <space> za
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview



" ===== Shortcut, Keyboard
set pastetoggle=<F2>
set showcmd " Shows last used command

inoremap jj <Esc>
nnoremap ; :

nnoremap j gj
nnoremap k gk
" g V visually shows block of text last added in INSERT
nnoremap gV `[v`]

nnoremap zz :w <Enter>
nnoremap ZZ :wq <Enter>

nnoremap <leader><space> :nohlsearch<CR>
"
" Flashes next search in red
function! HLNext (blinktime)
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#\%('.@/.'\)'
    let ring = matchadd('WhiteOnRed', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction
