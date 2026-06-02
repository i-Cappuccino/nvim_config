require("conform").setup({
  formatters_by_ft = {
    lua    = { "stylua" },
    python = { "ruff_format", "black" },
    cpp    = { "clang_format" },
    c      = { "clang_format" },
    json   = { "prettier" },
    yaml   = { "prettier" },
    markdown   = { "prettier" },
    html       = { "prettier" },
    css        = { "prettier" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    sh   = { "shfmt" },
    bash = { "shfmt" },
  },
  format_on_save = function(bufnr)
    if vim.g.disable_autoformat then return end
    local disable_fts = { "c", "cpp" }
    if vim.tbl_contains(disable_fts, vim.bo[bufnr].filetype) then
      local root = vim.fn.getcwd()
      local has_clang_format = vim.fn.findfile(".clang-format", root .. ";") ~= ""
      if not has_clang_format then return end
    end
    return { lsp_fallback = true, async = false, timeout_ms = 1000 }
  end,
})

vim.g.disable_autoformat = false
vim.api.nvim_create_user_command("FormatDisable", function()
  vim.g.disable_autoformat = true
  vim.notify("Format on save disabled", vim.log.levels.WARN)
end, { desc = "Disable format on save" })
vim.api.nvim_create_user_command("FormatEnable", function()
  vim.g.disable_autoformat = false
  vim.notify("Format on save enabled", vim.log.levels.INFO)
end, { desc = "Enable format on save" })
