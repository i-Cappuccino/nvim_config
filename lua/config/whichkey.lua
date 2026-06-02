local wk = require("which-key")

wk.setup({
  delay = 300,
  icons = { mappings = true },
})

wk.add({
  { "<leader>b",  group = "Buffers" },
  { "<leader>c",  group = "Code (format/action/rename/header-switch)" },
  { "<leader>d",  group = "Diagnostics" },
  { "<leader>f",  group = "Find (Telescope)" },
  { "<leader>g",  group = "Git" },
  { "<leader>s",  group = "Splits" },
  { "<leader>t",  group = "Terminal" },
  { "<leader>x",  group = "Trouble (Problems)" },
  { "<leader>dc", group = "Devcontainer" },
  { "g",          group = "Go to..." },
  { "[",          group = "Prev..." },
  { "]",          group = "Next..." },
})
