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
Plugin 'powerline/powerline'

Bundle 'edkolev/tmuxline.vim'

Plugin 'preservim/nerdtree'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" Put your non-Plugin stuff after this line

" ========== Macros
let @z = 'i#                    ========== jjbhi'
let @x = 'i# ========== '
let @c = 'i# === '
let @b = 'i"                    ========== jjbhi'
let @v = 'i" ========== '
let @n = 'i" === '
let @s = 'odef __init__(self):jj'

"                    ========== Plugin Keymap
map <C-n> :NERDTreeToggle<CR>


"                    ========== UI 
" ========== Powerline
let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'fancy'
let g:airline_theme='base16_grayscale'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_section_warning=""
let g:airline_symbols.linenr = ' -'
colorscheme tender
set term=xterm-256color
set t_ut=

" Add line column at 100
set colorcolumn=100
set cursorline " Shows a line under current line

set number " Turn's on number
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<
set list

" === Tabs, Spacing
set tabstop=4 shiftwidth=4 expandtab " Set spaces (Spaces > Tabs don't @ me!
set backspace=2 " backspace over everything in insert mode

set showmode " Shows current mode
set title " Show file name
set wildmenu " Helpful autocomplete menu
set laststatus=2
set modeline " Disabled mode line, for security reasons mostly

set nowrapscan " This is so searching doesn't wrap around and continue. When reach EOF it'll stop
set lazyredraw " Faster macros
set showmatch " Show matching () [] {}

set hlsearch " Highlights search
set incsearch " Search while typing
"
" ========== Editing, Syntax
set autoread " reload file if changed externally

syntax on
set encoding=utf-8 nobomb   " BOM often causes trouble, UTF-8 is awsum.
set spelllang=en_us         " spell checking
set spell
set autoindent

set foldenable " Allows folding
set foldlevelstart=10
set foldnestmax=10 " Max folding nest level
set foldmethod=indent " Fold according to indentation


"                    ========== Keyboard ==========
set pastetoggle=<F2>
set showcmd " Shows last used command

nnoremap <space> za
nnoremap zz :w <Enter>
nnoremap ZZ :wq <Enter>

nnoremap ; :
inoremap jj <Esc>
nnoremap j gj
nnoremap k gk
" g V visually shows block of text last added in INSERT
nnoremap gV `[v`]

" Search and replace word under cursor
nnoremap \f :%s/\<<C-r><C-w>\>//g<Left><Left>
" Search and replace visual selected
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
nnoremap \n :noh <Enter>
nnoremap \sp :set syntax=python <Enter>
nnoremap \syn :set syntax=
" Toggle line numbers and special characters like spaces and newline
nnoremap tc :set list! nu! <Enter>
nnoremap tr :reg <Enter>
nnoremap ti :set autoindent <Enter>
nnoremap ts :set spell! <Enter>
nnoremap te :e <Enter>
nnoremap tm :map <Enter>
nnoremap tvm :so ~/.vimrc <Enter>

nnoremap tn :NERDTreeToggle<CR>

xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>

function! s:VSetSearch()
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n','g')
    let @s = temp
endfunction
