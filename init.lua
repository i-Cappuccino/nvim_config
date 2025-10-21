vim.opt.runtimepath:prepend("~/.local/share/nvim/lazy/lazy.nvim")
require("lazy").setup(
{
  -- Theme
  { "folke/tokyonight.nvim" },

  -- File explorer
  { "nvim-tree/nvim-tree.lua" },

  -- Fuzzy finder
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- Syntax highlighting
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- Git
  { "lewis6991/gitsigns.nvim" },

  -- LSP and autocompletion
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "L3MON4D3/LuaSnip" },

  -- Status line
  { "nvim-lualine/lualine.nvim" },
})