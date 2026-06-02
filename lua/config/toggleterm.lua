require("toggleterm").setup({
  size = function(term)
    if term.direction == "horizontal" then return 15
    elseif term.direction == "vertical" then return math.floor(vim.o.columns * 0.4)
    end
  end,
  open_mapping = [[<C-\>]],
  hide_numbers = true,
  direction    = "float",
  close_on_exit = true,
  shell        = vim.o.shell,
  auto_scroll  = true,
  float_opts   = {
    border    = "curved",
    winblend  = 3,
    width     = function() return math.floor(vim.o.columns * 0.85) end,
    height    = function() return math.floor(vim.o.lines * 0.80) end,
  },
  highlights = {
    FloatBorder = { link = "FloatBorder" },
    NormalFloat = { link = "NormalFloat" },
  },
})

local Terminal = require("toggleterm.terminal").Terminal
local lazygit  = Terminal:new({
  cmd = "lazygit", hidden = true, direction = "float",
  float_opts = {
    border = "curved",
    width  = function() return vim.o.columns - 4 end,
    height = function() return vim.o.lines - 4 end,
  },
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "t", "q", "<cmd>close<CR>",
      { noremap = true, silent = true })
  end,
})

function _LAZYGIT_TOGGLE() lazygit:toggle() end
vim.keymap.set("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { desc = "LazyGit" })
