" Set line numbers
"
set number

" Set up font
set guifont=Fira\ Code:h16

" Automatic file type detection
filetype plugin indent on

" Prevent delay
set timeoutlen=1000 ttimeoutlen=0

" show existing tab with 4 spaces width
set tabstop=2

" when indenting with '>', use 4 spaces width
set shiftwidth=2

" On pressing tab, insert 4 spaces (disable for .tsv files)
set expandtab
autocmd BufNewFile,BufRead *.tsv set expandtab!

" Always allow backspace
set backspace=indent,eol,start

" Show next/previous 5 lines when scrolling
set scrolloff=5

" Always show status line
set laststatus=2

" Hide default mode status
set noshowmode

" Search while typing
set incsearch

" Don't search included files with autocomplete
set complete-=i

" Enable 256 color mode
set term=xterm-256color

" Use new syntax highlighting engine (otherwise TypeScript files are _very_ slow)
set re=0

" Wrap lines in a writer-friendly way
set linebreak

" Disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" vim-plug section
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'micha/vim-colors-solarized'
Plug 'morhetz/gruvbox'
"Plug 'sheerun/vim-polyglot'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'dhruvasagar/vim-table-mode'
Plug 'scrooloose/nerdcommenter'
"Plug 'lervag/vimtex'
Plug 'mattn/emmet-vim'
Plug 'junegunn/goyo.vim'
call plug#end()

" Set up color scheme
syntax on
set background=light
colorscheme solarized
let s:terminal_italic=1

" Persist undo history
set undofile
set undodir=~/.vim/undodir

" Enable syntax highlighting in code blocks in markdown files
let g:markdown_fenced_languages=['bash=sh', 'css', 'haskell', 'html', 'javascript', 'c']

" Interpret the following file types as TypeScript
autocmd BufNewFile,BufRead *.ts,*.tsx set filetype=typescript.tsx

" Disable ALE for assembly files
let g:ale_pattern_options = {'\.asm$': {'ale_enabled': 0}}

" ALE setup for Haskell
function CheckIfFileExists(filename)
  if filereadable(a:filename)
    return 1
  endif

  return 0
endfunction

" Begin custom Haskell linter
call ale#Set('haskell_my_cabal_options', '-fno-code -v0')

function! s:my_cabal_GetCommand(buffer) abort
  return 'cabal build '
  \ . ale#Var(a:buffer, 'haskell_my_cabal_options')
  \ . ' -- %s </dev/null'
endfunction

call ale#linter#Define('haskell', {
\  'name': 'my_cabal',
\  'aliases': ['my-cabal'],
\  'output_stream': 'stderr',
\  'executable': 'cabal',
\  'command': function('s:my_cabal_GetCommand'),
\  'callback': 'ale#handlers#haskell#HandleGHCFormat',
\})
" End custom Haskell linter

if !exists('g:ale_linters') | let g:ale_linters = {} | en
let g:ale_linters.haskell = ['my-cabal', 'hlint']

" Extra lightline config
let g:lightline = {
\   'colorscheme': 'solarized'
\}

let vimrc = ".vimrc file initialized."
