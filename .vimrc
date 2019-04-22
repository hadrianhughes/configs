let vimrc = ".vimrc file initialized."

" Set line numbers
set number
" Set up font
set guifont=Fira\ Code:h16
" Automatic file type detection
filetype plugin indent on
" Prevent delay
set timeoutlen=1000 ttimeoutlen=0
" Automatic filetype detection
filetype plugin on
" show existing tab with 4 spaces width
set tabstop=4
" " when indenting with '>', use 4 spaces width
set shiftwidth=4
" " On pressing tab, insert 4 spaces (Uncomment to use spaces)
" set expandtab
" Auto close braces and quotes
:inoremap ( ()<Esc>i
:inoremap { {}<Esc>i
:inoremap ' ''<Esc>i
:inoremap " ""<Esc>i

" vim-plug section
call plug#begin()
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'mattn/emmet-vim'
call plug#end()

" Set up color scheme
syntax on
colorscheme dracula

" Start and set up NERDTree
autocmd vimenter * NERDTree
let NERDTreeShowHidden=1

