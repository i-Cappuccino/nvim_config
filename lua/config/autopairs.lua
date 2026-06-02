require("nvim-autopairs").setup({
  check_ts = true,
  ts_config = {
    lua        = { "string" },
    javascript = { "template_string" },
    cpp        = { "string" },
  },
  disable_filetype = { "TelescopePrompt", "spectre_panel" },
  fast_wrap = {
    map     = "<M-e>",
    chars   = { "{", "[", "(", '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
    end_key = "$",
    keys    = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma  = true,
    highlight    = "PmenuSel",
    highlight_grey = "LineNr",
  },
})

-- ─── nvim-cmp Integration ────────────────────────────────────────────────────
-- When you confirm a function completion that ends in `(`, autopairs adds the
-- matching `)`. Without this, you'd get `myfunc()` then a stray `)` typed by
-- autopairs trying to match. The cmp dependency in plugins.lua guarantees cmp
-- is fully loaded by the time this runs — but we pcall anyway as a safety net.
local ok_cmp, cmp = pcall(require, "cmp")
local ok_ap,  cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if ok_cmp and ok_ap then
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end
