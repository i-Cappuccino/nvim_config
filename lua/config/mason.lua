require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = { "lua_ls", "pyright", "clangd", "tsserver" },
  automatic_installation = true,
}
