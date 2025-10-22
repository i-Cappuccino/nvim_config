local telescope = require("telescope")
telescope.setup({
  defaults = {
    cwd = vim.fn.expand("~"),
    layout_strategy = "horizontal",
    layout_config = { prompt_position = "top" },
    sorting_strategy = "ascending",
    prompt_prefix = "  ",
    mappings = {
      i = {
        ["<C-h>"] = "which_key",
      },
    },
  },
  pickers = {
    find_files = { hidden = true },
  },
})
