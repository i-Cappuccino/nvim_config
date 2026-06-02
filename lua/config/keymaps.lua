local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

<<<<<<< Updated upstream
-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
=======
---------------------------------------------------------------------------
-- GENERAL
---------------------------------------------------------------------------
keymap("n", "<leader>w",  ":w<CR>",   { desc = "Save" })
keymap("n", "<leader>q",  ":q<CR>",   { desc = "Quit" })
keymap("n", "<leader>Q",  ":qa!<CR>", { desc = "Quit all (force)" })

-- Clear search highlights
keymap("n", "<Esc>", ":nohl<CR>",  opts)

-- Select all
keymap("n", "<C-a>", "ggVG",  opts)

---------------------------------------------------------------------------
-- NAVIGATION — Tmux+Neovim unified
---------------------------------------------------------------------------
keymap("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>",  opts)
keymap("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>",  opts)
keymap("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>",    opts)
keymap("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", opts)

---------------------------------------------------------------------------
-- WINDOW MANAGEMENT
---------------------------------------------------------------------------
keymap("n", "<leader>sv", ":vsplit<CR>",  { desc = "Split vertical" })
keymap("n", "<leader>sh", ":split<CR>",   { desc = "Split horizontal" })
keymap("n", "<leader>sc", ":close<CR>",   { desc = "Close split" })
keymap("n", "<leader>so", ":only<CR>",    { desc = "Close other splits" })

keymap("n", "<C-Up>",    ":resize -2<CR>",          opts)
keymap("n", "<C-Down>",  ":resize +2<CR>",          opts)
keymap("n", "<C-Left>",  ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

---------------------------------------------------------------------------
-- BUFFER / TAB MANAGEMENT
---------------------------------------------------------------------------
keymap("n", "<S-h>",      ":BufferLineCyclePrev<CR>",  { desc = "Prev buffer" })
keymap("n", "<S-l>",      ":BufferLineCycleNext<CR>",  { desc = "Next buffer" })
keymap("n", "<leader>bd", ":bdelete<CR>",              { desc = "Close buffer" })
keymap("n", "<leader>bD", ":bdelete!<CR>",             { desc = "Force close buffer" })
keymap("n", "<leader>bo", ":%bdelete|edit #|normal `\"<CR>", { desc = "Close other buffers" })

---------------------------------------------------------------------------
-- LINE MOVEMENT (VS Code Alt+Up/Down)
---------------------------------------------------------------------------
keymap("n", "<M-j>", ":m .+1<CR>==",      opts)
keymap("n", "<M-k>", ":m .-2<CR>==",      opts)
keymap("v", "<M-j>", ":m '>+1<CR>gv=gv",  opts)
keymap("v", "<M-k>", ":m '<-2<CR>gv=gv",  opts)

keymap("n", "<M-S-j>", "yyp",  opts)
>>>>>>> Stashed changes

---------------------------------------------------------------------------
-- INDENT / DELETE / PASTE
---------------------------------------------------------------------------
keymap("v", "<",  "<gv",  opts)
keymap("v", ">",  ">gv",  opts)

keymap("n", "<leader>dh", '"_d',  { desc = "Delete (no yank)" })
keymap("v", "<leader>dh", '"_d',  { desc = "Delete (no yank)" })
keymap("v", "p",  '"_dP', opts)   -- Paste over selection without overwriting register

<<<<<<< Updated upstream
-- LSP
keymap("n", "gd", vim.lsp.buf.definition, opts)
keymap("n", "K", vim.lsp.buf.hover, opts)
keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
keymap("n", "gr", vim.lsp.buf.references, opts)
keymap("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, opts)
=======
---------------------------------------------------------------------------
-- CLIPBOARD
---------------------------------------------------------------------------
keymap({ "n", "v" }, "<leader>y", '"+y',  { desc = "Yank to clipboard" })
keymap({ "n", "v" }, "<leader>Y", '"+Y',  { desc = "Yank line to clipboard" })
keymap({ "n", "v" }, "<leader>p", '"+p',  { desc = "Paste from clipboard" })

---------------------------------------------------------------------------
-- FILE EXPLORER
---------------------------------------------------------------------------
keymap("n", "<leader>e",  ":NvimTreeToggle<CR>",  { desc = "Toggle explorer" })
keymap("n", "<leader>E",  ":NvimTreeFocus<CR>",   { desc = "Focus explorer" })

---------------------------------------------------------------------------
-- TELESCOPE — <leader>f is the FIND prefix
---------------------------------------------------------------------------
keymap("n", "<leader>ff", ":Telescope find_files<CR>",                 { desc = "Find files" })
keymap("n", "<leader>fg", ":Telescope live_grep<CR>",                  { desc = "Find in files (grep)" })
keymap("n", "<leader>fb", ":Telescope buffers<CR>",                    { desc = "Find open buffers" })
keymap("n", "<leader>fh", ":Telescope help_tags<CR>",                  { desc = "Find help" })
keymap("n", "<leader>fr", ":Telescope oldfiles<CR>",                   { desc = "Recent files" })
keymap("n", "<leader>fc", ":Telescope current_buffer_fuzzy_find<CR>",  { desc = "Find in current file" })
keymap("n", "<leader>fs", ":Telescope lsp_document_symbols<CR>",       { desc = "Find symbols" })
keymap("n", "<leader>fw", ":Telescope grep_string<CR>",                { desc = "Find word under cursor" })
keymap("n", "<leader>ft", ":TodoTelescope<CR>",                        { desc = "Find TODOs" })

---------------------------------------------------------------------------
-- CODE actions (<leader>c prefix — replaces conflicting <leader>f for format)
---------------------------------------------------------------------------
keymap({ "n", "v" }, "<leader>cf",
  function() require("conform").format({ async = true, lsp_fallback = true }) end,
  { desc = "Code format" })
keymap("n", "<leader>ca", vim.lsp.buf.code_action,  { desc = "Code action" })
keymap("n", "<leader>cr", vim.lsp.buf.rename,        { desc = "Code rename" })
-- <leader>ch is added per-buffer by lsp.lua when clangd attaches (header switch)

---------------------------------------------------------------------------
-- LSP navigation (global versions; lsp.lua adds buffer-local versions too)
---------------------------------------------------------------------------
keymap("n", "gd",  vim.lsp.buf.definition,              { desc = "Go to definition" })
keymap("n", "gD",  vim.lsp.buf.declaration,             { desc = "Go to declaration" })
keymap("n", "gi",  vim.lsp.buf.implementation,          { desc = "Go to implementation" })
keymap("n", "gr",  ":Telescope lsp_references<CR>",     { desc = "References" })
keymap("n", "gt",  vim.lsp.buf.type_definition,         { desc = "Type definition" })
keymap("n", "K",   vim.lsp.buf.hover,                   { desc = "Hover docs" })

---------------------------------------------------------------------------
-- DIAGNOSTICS
---------------------------------------------------------------------------
keymap("n", "[d",        vim.diagnostic.goto_prev,  { desc = "Prev diagnostic" })
keymap("n", "]d",        vim.diagnostic.goto_next,  { desc = "Next diagnostic" })
keymap("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })
keymap("n", "<leader>dv", vim.diagnostic.open_float, { desc = "Diagnostic float" })

---------------------------------------------------------------------------
-- TROUBLE (VS Code Problems panel)
---------------------------------------------------------------------------
keymap("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>",              { desc = "Diagnostics (workspace)" })
keymap("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Diagnostics (buffer)" })
keymap("n", "<leader>xs", "<cmd>Trouble symbols toggle<CR>",                  { desc = "Symbols" })
keymap("n", "<leader>xl", "<cmd>Trouble loclist toggle<CR>",                  { desc = "Location list" })
keymap("n", "<leader>xq", "<cmd>Trouble qflist toggle<CR>",                   { desc = "Quickfix list" })

---------------------------------------------------------------------------
-- GIT
---------------------------------------------------------------------------
keymap("n", "<leader>gg",  "<cmd>lua _LAZYGIT_TOGGLE()<CR>",  { desc = "LazyGit" })
keymap("n", "<leader>gd",  ":Gitsigns diffthis<CR>",          { desc = "Diff this" })
keymap("n", "<leader>gb",  ":Gitsigns blame_line<CR>",        { desc = "Blame line" })
keymap("n", "<leader>gB",  ":Git blame<CR>",                  { desc = "Blame full" })
keymap("n", "<leader>gs",  ":Gitsigns stage_hunk<CR>",        { desc = "Stage hunk" })
keymap("n", "<leader>gr",  ":Gitsigns reset_hunk<CR>",        { desc = "Reset hunk" })
keymap("n", "<leader>gp",  ":Gitsigns preview_hunk<CR>",      { desc = "Preview hunk" })
keymap("n", "]g",          ":Gitsigns next_hunk<CR>",         { desc = "Next git hunk" })
keymap("n", "[g",          ":Gitsigns prev_hunk<CR>",         { desc = "Prev git hunk" })

---------------------------------------------------------------------------
-- TODO
---------------------------------------------------------------------------
keymap("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next TODO" })
keymap("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Prev TODO" })

---------------------------------------------------------------------------
-- TERMINAL
---------------------------------------------------------------------------
keymap("n", "<leader>th", ":ToggleTerm direction=horizontal<CR>",  { desc = "Terminal horizontal" })
keymap("n", "<leader>tv", ":ToggleTerm direction=vertical<CR>",    { desc = "Terminal vertical" })
keymap("n", "<leader>tf", ":ToggleTerm direction=float<CR>",       { desc = "Terminal float" })

keymap("t", "<Esc>", "<C-\\><C-n>",                opts)
keymap("t", "jk",    "<C-\\><C-n>",                opts)
keymap("t", "<C-h>", "<cmd>TmuxNavigateLeft<CR>",  opts)
keymap("t", "<C-j>", "<cmd>TmuxNavigateDown<CR>",  opts)
keymap("t", "<C-k>", "<cmd>TmuxNavigateUp<CR>",    opts)
keymap("t", "<C-l>", "<cmd>TmuxNavigateRight<CR>", opts)

---------------------------------------------------------------------------
-- DEVCONTAINER
---------------------------------------------------------------------------
keymap("n", "<leader>dc", ":DevcontainerStart<CR>",  { desc = "Container start" })
keymap("n", "<leader>da", ":DevcontainerAttach<CR>", { desc = "Container attach" })
keymap("n", "<leader>de", ":DevcontainerExec<CR>",   { desc = "Container exec" })

---------------------------------------------------------------------------
-- INSERT MODE
---------------------------------------------------------------------------
keymap("i", "jk",  "<Esc>",  opts)
keymap("i", "kj",  "<Esc>",  opts)

keymap("i", "<C-h>",  "<Left>",   opts)
keymap("i", "<C-l>",  "<Right>",  opts)
keymap("i", "<C-j>",  "<Down>",   opts)
keymap("i", "<C-k>",  "<Up>",     opts)

keymap("i", "<M-Right>",  "<S-Right>",  opts)
keymap("i", "<M-Left>",   "<S-Left>",   opts)

keymap("i", "<C-o>",    "<Esc>o",   opts)
keymap("i", "<C-S-o>",  "<Esc>O",   opts)
keymap("i", "<C-BS>",   "<C-w>",    opts)

---------------------------------------------------------------------------
-- VISUAL/NORMAL — Word & Line jumps
---------------------------------------------------------------------------
keymap({ "n", "v" }, "<M-Right>", "w",  opts)
keymap({ "n", "v" }, "<M-Left>",  "b",  opts)
keymap({ "n", "v" }, "<C-e>",     "$",  opts)
>>>>>>> Stashed changes
