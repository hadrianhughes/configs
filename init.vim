" Set line numbers
set number

" Set up font
set guifont=Fira\ Code:h16

" Automatic file type detection
filetype plugin indent on

" Prevent delay
set timeoutlen=1000 ttimeoutlen=0

" Show existing tab with 4 spaces width
set tabstop=2

" When indenting with '>', use 4 spaces width
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

" Enable full colours
set termguicolors

" Wrap lines in a writer-friendly way
set linebreak

" Always use block cursor
set guicursor=n-v-c-i:block

" Don't highlight search results
set nohlsearch

" Disable mouse altogether
set mouse=

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
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-surround'
Plug 'neovim/nvim-lspconfig'
"Plug 'w0rp/ale'
Plug 'dhruvasagar/vim-table-mode'
Plug 'scrooloose/nerdcommenter'
Plug 'lepture/vim-jinja'
Plug 'prisma/vim-prisma'
Plug 'hashivim/vim-terraform'
Plug 'mattn/emmet-vim'
Plug 'robitx/gp.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
call plug#end()

" Set up color scheme
syntax on
set background=dark
let s:terminal_italic=1
colorscheme gruvbox

" Persist undo history
set undofile
set undodir=~/.local/state/nvim/undo


" Set up gp.nvim
lua << EOF
require("gp").setup({
  openai_api_key = os.getenv("OPENAI_API_KEY")
})
EOF

" Set up treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "json", "lua", "typescript", "bash", "c", "haskell", "html", "css" }, -- add any you want
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Jump forward to next text object
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
      },
    },
  }
}
EOF

" Set up telescope to work with ag
lua << EOF
require('telescope').load_extension('fzf')

require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'ag',
      '--nocolor',
      '--nogroup',
      '--column',
      '--smart-case'
    },
    prompt_prefix = '🔍 ',
    selection_caret = '➤ ',
    sorting_strategy = 'ascending',
    layout_strategy = 'horizontal',
    layout_config = {
      prompt_position = 'top',
    },
  }
}
EOF

" Bind :Telescope live_grep to Ctrl-F
nnoremap <C-f> :Telescope live_grep<CR>

" Enable syntax highlighting in code blocks in markdown files
let g:markdown_fenced_languages=['bash=sh', 'css', 'haskell', 'html', 'javascript', 'c']

autocmd BufRead,BufNewFile *.ts,*.tsx set filetype=typescript.tsx
autocmd BufRead,BufNewFile *.h set filetype=c

" Enable LSP servers
lua << EOF
local lspconfig = require('lspconfig')
local servers = { 'ts_ls', 'clangd', 'hls', 'bashls', 'jsonls', 'html', 'cssls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({})
end

vim.o.updatetime = 300
vim.cmd [[
  autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focus = false })
]]
EOF
