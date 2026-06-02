local opt = vim.opt

-- Line numbers (relative is essential for committing to Vim motions)
opt.number = true
opt.relativenumber = true

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.colorcolumn = "100"
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.showmode = false
opt.pumheight = 10

-- Files & Undo
opt.clipboard = "unnamedplus"
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undodir"

-- Performance
opt.updatetime = 250
opt.timeoutlen = 300

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Mouse
opt.mouse = "a"

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }

-- Misc
opt.conceallevel = 0
opt.fileencoding = "utf-8"
opt.cmdheight = 1
opt.confirm = true

vim.fn.mkdir(vim.fn.stdpath("data") .. "/undodir", "p")
