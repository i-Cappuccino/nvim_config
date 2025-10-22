local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"

vim.lsp.config('clangd', {
  cmd = { mason_bin .. "/clangd" },
  root_dir = function(fname)
    local root = vim.fs.find({ ".git", "compile_commands.json" }, { upward = true, path = fname })[1]
    return root and vim.fs.dirname(root) or vim.loop.cwd()
  end,
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})