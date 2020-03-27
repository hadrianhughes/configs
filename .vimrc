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
set tabstop=2

" when indenting with '>', use 4 spaces width
set shiftwidth=2

" On pressing tab, insert 4 spaces (Uncomment to use spaces)
set expandtab

" Always allow backspace
set backspace=indent,eol,start

" Set relative line numbers
set relativenumber

" Show next/previous 5 lines when scrolling
set scrolloff=5

" Always show status line
set laststatus=2

" Disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" Auto close braces and quotes
inoremap ( ()<Esc>i
inoremap { {}<Esc>i
inoremap " ""<Esc>i
inoremap [ []<Esc>i

" vim-plug section
call plug#begin()
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'sheerun/vim-polyglot'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
" Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'mattn/emmet-vim'
" Plug 'Valloric/YouCompleteMe'
Plug 'dhruvasagar/vim-table-mode'
Plug 'scrooloose/nerdcommenter'
Plug 'ctrlpvim/ctrlp.vim'
call plug#end()

" Set up color scheme
syntax on
let g:dracula_italic = 0
colorscheme dracula
highlight Normal ctermbg=236

" Start and set up NERDTree
" autocmd vimenter * NERDTree
" let NERDTreeShowHidden=1

" Settings for nerdcommenter
let g:NERDSpaceDelims=1

" Configure YouCompleteMe
" set completeopt-=preview

" Enable syntax highlighting in code blocks in markdown files
let g:markdown_fenced_languages=['bash=sh', 'css', 'haskell', 'html', 'javascript', 'c']

autocmd BufNewFile,BufRead *.ts,*.tsx set filetype=typescript.tsx

let g:ale_linters = {
\   'typescript': ['eslint']
\}

let vimrc = ".vimrc file initialized."
