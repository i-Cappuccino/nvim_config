local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"

vim.lsp.config('pyright', {
  cmd = { mason_bin .. "/pyright-langserver", "--stdio" },
  root_dir = function(fname)
    local root = vim.fs.find({ ".git", "pyproject.toml" }, { upward = true, path = fname })[1]
    return root and vim.fs.dirname(root) or vim.loop.cwd()
  end,
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})