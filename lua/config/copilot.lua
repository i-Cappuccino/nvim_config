require("copilot").setup({
  panel = { enabled = false },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 75,
    keymap = {
      accept      = "<M-CR>",
      accept_word = "<M-w>",
      accept_line = "<M-l>",
      next        = "<M-]>",
      prev        = "<M-[>",
      dismiss     = "<C-]>",
    },
  },
  filetypes = {
    yaml = false, markdown = true, help = false,
    gitcommit = true, gitrebase = false, ["."] = false,
  },
  server_opts_overrides = { trace = "messages" },
})
