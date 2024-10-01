vim.opt.number = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.guicursor = 'n-v-c-i:block'

vim.opt.termguicolors = true

-- Set up lazy
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set up dependencies
require('lazy').setup({
  { 'ellisonleao/gruvbox.nvim', priority = 1000 , config = true, lazy = false, opts = ...},
	{ 'neovim/nvim-lspconfig', lazy = true },
	{ 'kylechui/nvim-surround', lazy = true },
	{ 'dhruvasagar/vim-table-mode', lazy = true },
	{ 'f-person/git-blame.nvim', lazy = false },
	{
		'Julian/lean.nvim',
		event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },

		dependencies = {
			'neovim/nvim-lspconfig',
			'nvim-lua/plenary.nvim',
			-- you also will likely want nvim-cmp or some completion engine
		},

		-- see details below for full configuration options
		opts = {
			lsp = {},
			mappings = true,
		}
	}
})

vim.cmd.colorscheme('gruvbox')
require'nvim-surround'.setup{}
