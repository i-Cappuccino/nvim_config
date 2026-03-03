local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    path_display = { "truncate" },
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous, -- Move up in results
        ["<C-j>"] = actions.move_selection_next,     -- Move down in results
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      },
    },
  },
})

-- Keymaps (Add these to your config/keymaps.lua or keep here)
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files (Ctrl+P)' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Grep Search (Find in Files)' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find Open Buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find Help Docs' })
