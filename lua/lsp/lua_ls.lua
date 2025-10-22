local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"

vim.lsp.config('lua_ls', {
  cmd = { mason_bin .. "/lua-language-server" },
  root_dir = function(fname)
    local root = vim.fs.find({ ".git" }, { upward = true, path = fname })[1]
    return root and vim.fs.dirname(root) or vim.loop.cwd()
  end,
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  on_attach = function(_, bufnr)
    local opts = { buffer = bufnr, noremap = true, silent = true }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, opts)
  end,
})