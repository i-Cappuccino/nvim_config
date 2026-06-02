require("gitsigns").setup({
  signs = {
    add          = { text = "▎" },
    change       = { text = "▎" },
    delete       = { text = "" },
    topdelete    = { text = "" },
    changedelete = { text = "▎" },
    untracked    = { text = "┆" },
  },
  current_line_blame = false,
  current_line_blame_opts = {
    virt_text = true, virt_text_pos = "eol",
    delay = 500, ignore_whitespace = false,
  },
  current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> • <summary>",

  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local bopts = { buffer = bufnr, noremap = true, silent = true }

    vim.keymap.set("n", "]g", function()
      if vim.wo.diff then return "]g" end
      vim.schedule(gs.next_hunk)
      return "<Ignore>"
    end, { expr = true, buffer = bufnr, desc = "Next git hunk" })

    vim.keymap.set("n", "[g", function()
      if vim.wo.diff then return "[g" end
      vim.schedule(gs.prev_hunk)
      return "<Ignore>"
    end, { expr = true, buffer = bufnr, desc = "Prev git hunk" })

    vim.keymap.set("n", "<leader>gs", gs.stage_hunk,      { buffer = bufnr, desc = "Stage hunk" })
    vim.keymap.set("n", "<leader>gr", gs.reset_hunk,      { buffer = bufnr, desc = "Reset hunk" })
    vim.keymap.set("n", "<leader>gS", gs.stage_buffer,    { buffer = bufnr, desc = "Stage buffer" })
    vim.keymap.set("n", "<leader>gR", gs.reset_buffer,    { buffer = bufnr, desc = "Reset buffer" })
    vim.keymap.set("n", "<leader>gp", gs.preview_hunk,    { buffer = bufnr, desc = "Preview hunk" })
    vim.keymap.set("n", "<leader>gu", gs.undo_stage_hunk, { buffer = bufnr, desc = "Undo stage hunk" })
    vim.keymap.set("n", "<leader>gb", function() gs.blame_line({ full = true }) end,
      { buffer = bufnr, desc = "Blame line (full)" })
    vim.keymap.set("n", "<leader>gL", gs.toggle_current_line_blame,
      { buffer = bufnr, desc = "Toggle line blame" })
    vim.keymap.set("n", "<leader>gd", gs.diffthis, { buffer = bufnr, desc = "Diff this" })
    vim.keymap.set("n", "<leader>gD", function() gs.diffthis("~") end,
      { buffer = bufnr, desc = "Diff vs HEAD~1" })

    vim.keymap.set("v", "<leader>gs",
      function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
      { buffer = bufnr, desc = "Stage selected lines" })
    vim.keymap.set("v", "<leader>gr",
      function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
      { buffer = bufnr, desc = "Reset selected lines" })

    vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", bopts)
    vim.keymap.set({ "o", "x" }, "ah", ":<C-U>Gitsigns select_hunk<CR>", bopts)
  end,
})
