require("mason").setup({
  ui = {
    border = "rounded",
    icons = {
      package_installed   = "✓",
      package_pending     = "➜",
      package_uninstalled = "✗",
    },
  },
})

require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "pyright", "clangd" },
  automatic_installation = true,
})

-- Formatters/linters used by conform.nvim — install manually:
--   :MasonInstall stylua ruff black clang-format prettier shfmt
