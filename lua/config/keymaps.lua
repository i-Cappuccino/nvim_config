-- Leader key
vim.g.mapleader = " "

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- General
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)

-- Tmux Navigation (Handles both Nvim splits AND Tmux panes)
-- We use these INSTEAD of the standard <C-w> maps
keymap("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", opts)
keymap("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", opts)
keymap("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", opts)
keymap("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", opts)

-- Resize windows
keymap("n", "<C-Up>",    ":resize -2<CR>", opts)
keymap("n", "<C-Down>",  ":resize +2<CR>", opts)
keymap("n", "<C-Left>",  ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Split windows
keymap("n", "<leader>sv", ":vsplit<CR>", opts)
keymap("n", "<leader>sh", ":split<CR>", opts)

-- Close current window
keymap("n", "<leader>sc", ":close<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)

-- File explorer
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Devcontainer
keymap("n", "<leader>dc", ":DevcontainerStart<CR>", opts)
keymap("n", "<leader>da", ":DevcontainerAttach<CR>", opts)
keymap("n", "<leader>de", ":DevcontainerExec<CR>", opts)

-- LSP
keymap("n", "gd", vim.lsp.buf.definition, opts)
keymap("n", "K", vim.lsp.buf.hover, opts)
keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
keymap("n", "gr", vim.lsp.buf.references, opts)
keymap("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, opts)

-- Visual Mode: Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- System Clipboard Mappings
keymap("n", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
keymap("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
keymap("n", "<leader>p", '"+p', { desc = "Paste from system clipboard" })

-- Word Navigation
keymap({ "n", "v" }, "<M-Right>", "w", opts) 
keymap({ "n", "v" }, "<M-Left>", "b", opts)  

-- Line Start/End
keymap({ "n", "v" }, "<C-a>", "^", opts)    
keymap({ "n", "v" }, "<C-e>", "$", opts)    

-- Insert Mode Keymap --
keymap("i", "jk", "<Esc>", opts)
keymap("i", "kj", "<Esc>", opts)

-- Move within insert mode 
keymap("i", "<C-h>", "<Left>", opts)
keymap("i", "<C-l>", "<Right>", opts)
keymap("i", "<C-j>", "<Down>", opts)
keymap("i", "<C-k>", "<Up>", opts)

-- Move by word in Insert mode (Alt + Arrows)
keymap("i", "<M-Right>", "<S-Right>", opts)
keymap("i", "<M-Left>", "<S-Left>", opts)

-- Line breaks / Deletion
keymap("i", "<C-o>", "<Esc>o", opts)  
keymap("i", "<C-S-o>", "<Esc>O", opts)
keymap("i", "<C-BS>", "<C-w>", opts)  
keymap("i", "<C-u>", "<C-u>", opts)
