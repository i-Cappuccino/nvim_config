vim.g.mapleader = " "
vim.g.maplocalleader = " "

<<<<<<< Updated upstream
vim.opt.runtimepath:prepend("~/.local/share/nvim/lazy/lazy.nvim")
require("lazy").setup("plugins")

require("config.mason")
require("config.lsp")
require("config.cmp")
require("config.explorer")
require("config.telescope")
require("config.devcontainer")
=======
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
>>>>>>> Stashed changes
require("config.keymaps")
