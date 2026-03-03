vim.g.mapleader = " "

-- Bootstrapping: Automatically find the data path regardless of OS/Env
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins and configurations
require("lazy").setup("plugins")

require("config.mason")
require("config.lsp")
require("config.cmp")
require("config.explorer")
require("config.telescope")
-- require("config.devcontainer") -- Uncomment once you're ready to test Docker logic
require("config.keymaps")
require("config.lualine")
require("config.treesitter")
require("config.copilot")
