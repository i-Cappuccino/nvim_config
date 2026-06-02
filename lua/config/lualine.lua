require("lualine").setup({
  options = {
    theme = "tokyonight",
    globalstatus = true,
    component_separators = { left = "", right = "" },
    section_separators   = { left = "", right = "" },
    disabled_filetypes   = { statusline = { "NvimTree", "lazy" } },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      "branch",
      { "diff",        symbols = { added = " ", modified = " ", removed = " " } },
      { "diagnostics", symbols = { error = " ", warn = " ", hint = " ", info = " " } },
    },
    lualine_c = {
      { "filename", path = 1,
        symbols = { modified = "  ", readonly = "", unnamed = "[No Name]" } },
    },
    lualine_x = {
      {
        function()
          local clients = vim.lsp.get_clients({ bufnr = 0 })
          if #clients == 0 then return "" end
          local names = {}
          for _, c in ipairs(clients) do
            if c.name ~= "copilot" then table.insert(names, c.name) end
          end
          return #names > 0 and ("  " .. table.concat(names, ", ")) or ""
        end,
        color = { fg = "#7aa2f7" },
      },
      "encoding", "fileformat", "filetype",
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_c = { { "filename", path = 1 } },
    lualine_x = { "location" },
  },
})
