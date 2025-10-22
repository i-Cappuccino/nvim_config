vim.opt.runtimepath:prepend("~/.local/share/nvim/lazy/lazy.nvim")
require("lazy").setup("plugins")

require("config.mason")
require("config.lsp")
require("config.cmp")

