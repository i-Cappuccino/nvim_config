local telescope = require("telescope")
local actions   = require("telescope.actions")

telescope.setup({
  defaults = {
    path_display = { "truncate" },
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = { prompt_position = "top", preview_width = 0.55 },
      vertical   = { mirror = false },
      width = 0.87, height = 0.80, preview_cutoff = 120,
    },
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<Esc>"] = actions.close,
        ["<C-c>"] = actions.close,
        ["<C-u>"] = false,
        ["<C-d>"] = actions.delete_buffer,
      },
      n = {
        ["q"] = actions.close,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      },
    },
    file_ignore_patterns = { "%.git/", "node_modules/", "%.DS_Store", "build/", "__pycache__/" },
    vimgrep_arguments = {
      "rg", "--color=never", "--no-heading",
      "--with-filename", "--line-number",
      "--column", "--smart-case",
      "--hidden", "--glob=!.git/*",
    },
  },
  pickers = {
    find_files     = { hidden = true, follow = true },
    buffers        = { sort_mru = true, previewer = false },
    lsp_references = { fname_width = 60 },
  },
})

pcall(telescope.load_extension, "fzf")
