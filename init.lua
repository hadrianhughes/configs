vim.opt.number = true

-- Ignore case when searching, unless search term includes an uppercase
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Don't highlight previous search results
vim.opt.hlsearch = true

vim.opt.wrap = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.guicursor = "n-v-c-i:block"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, lazy = true, opts = ...},
	{ "neovim/nvim-lspconfig", lazy = true }
})

vim.opt.termguicolors = true
vim.cmd.colorscheme('gruvbox')

require("lspconfig").hls.setup({})
