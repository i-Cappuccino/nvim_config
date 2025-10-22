require("nvim-tree").setup({
  sort = { sorter = "case_sensitive" },
  view = { width = 35 },
  renderer = { group_empty = true },
  filters = { dotfiles = false },
})

-- Keymap to toggle file explorer
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })