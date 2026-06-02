require("trouble").setup({
  modes = {
    diagnostics = {
      auto_open    = false,
      auto_close   = true,
      auto_preview = true,
      focus        = false,
    },
  },
  icons = {
    error = " ", warning = " ",
    hint  = " ", info    = " ",
  },
})
