local cmp = require("cmp")
local luasnip = require("luasnip")

<<<<<<< Updated upstream
cmp.setup({
  snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
=======
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },

  window = {
    completion    = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  mapping = cmp.mapping.preset.insert({
    ["<C-b>"]     = cmp.mapping.scroll_docs(-4),
    ["<C-f>"]     = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"]     = cmp.mapping.abort(),
    ["<CR>"]      = cmp.mapping.confirm({ select = true }),

>>>>>>> Stashed changes
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),

  sources = cmp.config.sources({
<<<<<<< Updated upstream
    { name = "nvim_lsp" },
    { name = "luasnip" },
=======
    { name = "nvim_lsp", priority = 1000 },
    { name = "luasnip",  priority = 750 },
    { name = "path",     priority = 500 },
>>>>>>> Stashed changes
  }, {
    { name = "buffer" },
    { name = "path" },
  }),
<<<<<<< Updated upstream
=======

  formatting = {
    format = function(entry, vim_item)
      local icons = {
        Text = "󰉿", Method = "󰆧", Function = "󰊕", Constructor = "",
        Field = "󰜢", Variable = "󰀫", Class = "󰠱", Interface = "",
        Module = "", Property = "󰜢", Unit = "󰑭", Value = "󰎟",
        Enum = "", Keyword = "󰌋", Snippet = "", Color = "󰏘",
        File = "󰈙", Reference = "󰈇", Folder = "󰉋", EnumMember = "",
        Constant = "󰏿", Struct = "󰙅", Event = "", Operator = "󰆕",
        TypeParameter = "󰅲",
      }
      vim_item.kind = string.format("%s %s", icons[vim_item.kind] or "", vim_item.kind)
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip  = "[Snip]",
        buffer   = "[Buf]",
        path     = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },

  experimental = {
    ghost_text = false,  -- Disabled — Copilot's inline suggestions cover this
  },
>>>>>>> Stashed changes
})
