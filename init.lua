local opt = vim.opt

opt.number = true
opt.guifont = "Fira Code:h16"

opt.smarttab = true
opt.autoindent = true
opt.smartindent = true

opt.timeoutlen = 1000
opt.ttimeoutlen = 0

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

opt.backspace = { "indent", "eol", "start" }

opt.scrolloff = 5
opt.laststatus = 2
opt.showmode = false
opt.incsearch = true
opt.complete:remove("i")

opt.termguicolors = true
opt.linebreak = true
opt.guicursor = "n-v-c-i:block"
opt.hlsearch = false
opt.mouse = ""

vim.cmd([[
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
  Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
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
]])

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

vim.cmd([[
  " Bind :Telescope live_grep to Ctrl-F
  nnoremap <C-f> :Telescope live_grep<CR>

  " Enable syntax highlighting in code blocks in markdown files
  let g:markdown_fenced_languages=['bash=sh', 'css', 'haskell', 'html', 'javascript', 'c']

  autocmd BufRead,BufNewFile *.ts,*.tsx set filetype=typescript.tsx
  autocmd BufRead,BufNewFile *.h set filetype=c
]])

-- Enable LSP servers
local lspconfig = require('lspconfig')
local servers = { 'ts_ls', 'clangd', 'hls', 'bashls', 'jsonls', 'html', 'cssls', 'rust_analyzer' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({})
end

require'lspconfig'.terraformls.setup {
  cmd = { "terraform-ls", "serve" },
  filetypes = { "terraform", "tf", "hcl" },
  root_dir = require('lspconfig.util').root_pattern('.terraform', '.git', '*.tf'),
  settings = {},
}

vim.o.updatetime = 300
vim.cmd [[
  autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focus = false })
]]

vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
