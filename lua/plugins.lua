return {
<<<<<<< Updated upstream
  -- Theme
  { "folke/tokyonight.nvim" },

  -- Treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- File explorer
  { "nvim-tree/nvim-tree.lua" },

  -- Telescope
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- Git
  { "lewis6991/gitsigns.nvim" },

  -- Status line
  { "nvim-lualine/lualine.nvim" },

  -- LSP and completion
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },

-- Devcontainer support (VSCode-like)
{ 
  "debdutdeb/devcontainer.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("devcontainer").setup({
      generate_commands = true, -- creates :DevcontainerStart, :DevcontainerAttach, etc.
      autocommands = { init = false, clean = false },
      attach_mounts = { container_runtime = "docker" },
    })
  end
}
=======

  ---------------------------------------------------------------------------
  -- Colorscheme (loads first, non-lazy)
  ---------------------------------------------------------------------------
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = { style = "night", transparent = false },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd("colorscheme tokyonight")
    end,
  },

  ---------------------------------------------------------------------------
  -- Shared dependencies
  ---------------------------------------------------------------------------
  { "nvim-lua/plenary.nvim",        lazy = true },
  { "nvim-tree/nvim-web-devicons",  lazy = true },

  ---------------------------------------------------------------------------
  -- Syntax & Language Intelligence
  ---------------------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function() require("config.treesitter") end,
  },

  ---------------------------------------------------------------------------
  -- LSP Stack
  ---------------------------------------------------------------------------
  {
    "williamboman/mason.nvim",
    config = function() require("config.mason") end,
  },
  { "williamboman/mason-lspconfig.nvim", lazy = true },

  -- cmp-nvim-lsp gets its own top-level entry so lspconfig can load it
  -- independently of nvim-cmp (lsp.lua requires it for capabilities)
  { "hrsh7th/cmp-nvim-lsp", lazy = true },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",   -- Required by lsp.lua for capabilities
    },
    config = function() require("config.lsp") end,
  },

  -- LSP progress spinner in the corner
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = { notification = { window = { winblend = 0 } } },
  },

  ---------------------------------------------------------------------------
  -- Completion
  ---------------------------------------------------------------------------
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function() require("config.cmp") end,
  },

  ---------------------------------------------------------------------------
  -- Auto-Pairs
  -- CRITICAL: dependencies includes nvim-cmp so lazy loads cmp FULLY before
  -- autopairs runs its config. Without this, autopairs's require("cmp") races
  -- with nvim-cmp's own load and triggers a circular require.
  ---------------------------------------------------------------------------
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = { "hrsh7th/nvim-cmp" },   -- ← THE FIX
    config = function() require("config.autopairs") end,
  },

  ---------------------------------------------------------------------------
  -- Formatting
  ---------------------------------------------------------------------------
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd  = { "ConformInfo" },
    config = function() require("config.conform") end,
  },

  ---------------------------------------------------------------------------
  -- AI Completion
  ---------------------------------------------------------------------------
  {
    "zbirenbaum/copilot.lua",
    event  = "InsertEnter",
    config = function() require("config.copilot") end,
  },

  ---------------------------------------------------------------------------
  -- File Explorer
  ---------------------------------------------------------------------------
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile" },
    config = function() require("config.explorer") end,
  },

  ---------------------------------------------------------------------------
  -- Fuzzy Finder
  ---------------------------------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    version  = "0.1.x",
    cmd  = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function() require("config.telescope") end,
  },

  ---------------------------------------------------------------------------
  -- Motion (game-changing for Vim navigation)
  -- s<char><char> → label every match → press label to jump
  -- Replaces sneak/leap/easymotion. The single best motion plugin.
  ---------------------------------------------------------------------------
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts  = {
      modes = {
        char  = { enabled = false },  -- Don't override f/F/t/T (keep vim defaults)
        search = { enabled = false }, -- Don't auto-flash during /
      },
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,        desc = "Flash jump" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,  desc = "Flash treesitter" },
      { "r", mode = "o",               function() require("flash").remote() end,      desc = "Remote flash" },
    },
  },

  ---------------------------------------------------------------------------
  -- Buffer Tabs
  ---------------------------------------------------------------------------
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    event  = "VeryLazy",
    config = function() require("config.bufferline") end,
  },

  ---------------------------------------------------------------------------
  -- Status Line
  ---------------------------------------------------------------------------
  {
    "nvim-lualine/lualine.nvim",
    event  = "VeryLazy",
    config = function() require("config.lualine") end,
  },

  ---------------------------------------------------------------------------
  -- Terminal
  ---------------------------------------------------------------------------
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd  = { "ToggleTerm" },
    keys = { [[<C-\>]] },
    config = function() require("config.toggleterm") end,
  },

  ---------------------------------------------------------------------------
  -- Text objects / Editing
  ---------------------------------------------------------------------------
  {
    "kylechui/nvim-surround",
    version = "*",
    event   = "VeryLazy",
    config  = true,
  },

  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = true,
  },

  ---------------------------------------------------------------------------
  -- Indent Guides
  ---------------------------------------------------------------------------
  {
    "lukas-reineke/indent-blankline.nvim",
    main  = "ibl",
    event = "BufReadPost",
    opts  = {
      indent = { char = "│" },
      scope  = { enabled = true, show_start = false },
    },
  },

  ---------------------------------------------------------------------------
  -- Diagnostics Panel
  ---------------------------------------------------------------------------
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    cmd = { "Trouble" },
    config = function() require("config.trouble") end,
  },

  ---------------------------------------------------------------------------
  -- TODO Comments
  ---------------------------------------------------------------------------
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    event = "BufReadPost",
    opts  = {},
  },

  ---------------------------------------------------------------------------
  -- Git
  ---------------------------------------------------------------------------
  {
    "lewis6991/gitsigns.nvim",
    event  = "BufReadPre",
    config = function() require("config.gitsigns") end,
  },
  { "tpope/vim-fugitive", cmd = { "Git", "G" } },

  ---------------------------------------------------------------------------
  -- Which-key
  ---------------------------------------------------------------------------
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function() require("config.whichkey") end,
  },

  ---------------------------------------------------------------------------
  -- Tmux Navigator
  ---------------------------------------------------------------------------
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  ---------------------------------------------------------------------------
  -- Devcontainer
  ---------------------------------------------------------------------------
  {
    "debdutdeb/devcontainer.nvim",
    cmd = { "DevcontainerStart", "DevcontainerAttach", "DevcontainerExec" },
    config = function() require("config.devcontainer") end,
  },

>>>>>>> Stashed changes
}
