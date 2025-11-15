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
  Plug 'mattn/emmet-vim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
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
  ensure_installed = { "json", "lua", "typescript", "bash", "c", "haskell", "html", "css", "wgsl" }, -- add any you want
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

-- Minimal nvim-cmp setup
local cmp = require("cmp")

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = "nvim_lsp" },
  },
})

-- Make LSP advertise cmp support
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.o.completeopt = "menu,menuone,noselect"

-- Enable LSP servers
local lspconfig = require('lspconfig')
local servers = { 'ts_ls', 'clangd', 'hls', 'bashls', 'jsonls', 'html', 'cssls', 'rust_analyzer' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    capabilities = capabilities,
  })
end

vim.o.updatetime = 300
vim.cmd [[
  autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focus = false })
]]

-- Set up 'go definition' and 'go declaration'
vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
