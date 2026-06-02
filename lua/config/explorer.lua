local ok, nvimtree = pcall(require, "nvim-tree")
if not ok then return end

vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

nvimtree.setup({
  sort = { sorter = "case_sensitive" },
  update_focused_file = { enable = true, update_root = false },
  view = { width = 35, side = "left", number = false, relativenumber = false },
  renderer = {
    group_empty   = true,
    highlight_git = true,
    indent_markers = { enable = true },
    icons = {
      show = { file = true, folder = true, folder_arrow = true, git = true },
      glyphs = {
        git = {
          unstaged = "✗", staged = "✓", unmerged = "",
          renamed = "➜", untracked = "★", deleted = "", ignored = "◌",
        },
      },
    },
  },
  filters = { dotfiles = false, custom = { ".DS_Store", "^.git$" } },
  diagnostics = {
    enable = true, show_on_dirs = true,
    icons = { hint = "", info = "", warning = "", error = "" },
  },
  git = { enable = true, ignore = false },
  actions = {
    open_file = { resize_window = true, window_picker = { enable = true } },
  },
})
