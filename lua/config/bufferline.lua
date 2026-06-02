require("bufferline").setup({
  options = {
    mode = "buffers",
    themable = true,
    numbers = "none",
    close_command        = "bdelete! %d",
    right_mouse_command  = "bdelete! %d",
    left_mouse_command   = "buffer %d",
    middle_mouse_command = "bdelete! %d",
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
    offsets = {
      { filetype = "NvimTree", text = "  Explorer", text_align = "left", separator = true },
    },
    color_icons             = true,
    show_buffer_close_icons = true,
    show_close_icon         = false,
    show_tab_indicators     = true,
    persist_buffer_sort     = true,
    separator_style         = "thin",
    always_show_bufferline  = true,
    sort_by                 = "insert_after_current",
  },
})
