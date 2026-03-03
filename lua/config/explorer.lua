local status, nvimtree = pcall(require, "nvim-tree")
if not status then
  return
end

nvimtree.setup({
  sort = { sorter = "case_sensitive" },
  -- Automatically update the tree to focus the file you are currently editing
  update_focused_file = {
    enable = true,
    update_root = true,
  },
  view = {
    width = 35,
    side = "left",
    -- Shows line numbers in the explorer (optional, but some find it helpful)
    number = false,
    relativenumber = false,
  },
  renderer = {
    group_empty = true,
    -- Highlights files based on Git status in the sidebar
    highlight_git = true,
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  filters = {
    dotfiles = false,
    custom = { ".DS_Store", "^.git$" }, -- Hide the .git folder to keep it clean
  },
  diagnostics = {
    enable = true, -- Shows LSP errors/warnings icons in the file tree
    show_on_dirs = true,
  },
})

-- Keymap (I've added focus for better UX)
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })








