local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, opts)
end

local servers = { "lua_ls", "pyright", "clangd", "ts_ls" } -- tsserver renamed
for _, s in ipairs(servers) do
  require("lspconfig")[s].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
