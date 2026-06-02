vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load options BEFORE plugins (no plugin deps)
require("config.options")

-- Lazy handles every plugin's config inside plugins.lua — do NOT re-require here
require("lazy").setup("plugins", {
  change_detection = { notify = false },
  ui = { border = "rounded" },
})

-- Load keymaps AFTER plugins so all commands (:Telescope, etc.) exist
require("config.keymaps")
