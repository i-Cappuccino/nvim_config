local status, ts = pcall(require, "nvim-treesitter.configs")
if not status then
  return
end

ts.setup({
  -- A list of parser names, or "all" (not recommended to use "all" as it's slow)
  ensure_installed = {
    "lua",
    "vim",
    "vimdoc",
    "query",
    "markdown",
    "markdown_inline",
    "cpp", -- Since you're dealing with Conan/DDS
    "python",
    "json",
    "yaml",
    "dockerfile",
    "bash",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set to false if you experience performance issues.
    additional_vim_regex_highlighting = false,
  },

  -- Enable indentation based on treesitter (experimental but usually good)
  indent = { enable = true },

  -- Incremental selection: Your VS Code "Expand Selection" equivalent
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
})
