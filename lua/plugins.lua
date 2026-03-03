return {
  -- Colorscheme
  { "folke/tokyonight.nvim", lazy = false, priority = 1000, config = function() vim.cmd([[colorscheme tokyonight]]) end },

  -- The Core Architecture
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function() require("config.treesitter") end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    config = function() require("config.explorer") end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require("config.telescope") end,
  },

  -- LSP & Completion Stack
  { "williamboman/mason.nvim", config = function() require("config.mason") end },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig", config = function() require("config.lsp") end },
  
  { 
    "hrsh7th/nvim-cmp", 
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function() require("config.cmp") end 
  },

  -- Dev Tools
  {
    "debdutdeb/devcontainer.nvim",
    config = function() require("config.devcontainer") end,
  },

  {
    "zbirenbaum/copilot.lua",
    -- Remove 'cmd = "Copilot"' to allow auto_trigger to work immediately
    event = "InsertEnter", 
    config = function()
      require("copilot").setup({
        suggestion = { 
          enabled = true, 
          auto_trigger = true, 
          keymap = { accept = "<M-CR>" } -- Changed to Alt+Enter to avoid Ctrl+L conflict
        },
      })
    end,
  },

  -- UI & Quality of Life
  { "lewis6991/gitsigns.nvim", opts = {} },
  { "nvim-lualine/lualine.nvim", opts = {} },
  { "akinsho/toggleterm.nvim", version = "*", config = true },
  { "folke/which-key.nvim", event = "VeryLazy", opts = {} },
  { "tpope/vim-fugitive" },
  { "nvim-tree/nvim-web-devicons" },

  -- Seamless Navigation
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    -- We keep these here, they will now correctly trigger since Copilot is moved
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>" },
    },
  }
}
	
