local cmp = require("cmp")
local luasnip = require("luasnip")

-- Load snippets from friendly-snippets (standard for VS Code-like experience)
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  -- Visual styling for the completion menu
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    -- select = false means you must explicitly pick one; 
    -- select = true (your current) means Enter always picks the top one.
    ["<CR>"] = cmp.mapping.confirm({ select = true }), 
    
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp", priority = 1000 }, -- LSP results first
    { name = "luasnip",  priority = 750 },
    { name = "path",     priority = 500 },
  }, {
    { name = "buffer",   priority = 250 },
  }),
  formatting = {
    -- This adds icons to the completion menu (requires nvim-web-devicons)
    format = function(entry, vim_item)
      local icons = {
        Text = "󰉿", Method = "󰆧", Function = "󰊕", Constructor = "",
        Field = "󰜢", Variable = "󰀫", Class = "󰠱", Interface = "",
        Module = "", Property = "󰜢", Unit = "󰑭", Value = "󰎟",
        Enum = "", Keyword = "󰌋", Snippet = "", Color = "󰏘",
        File = "󰈙", Reference = "󰈇", Folder = "󰉋", EnumMember = "",
        Constant = "󰏿", Struct = "󰙅", Event = "", Operator = "󰆕",
        TypeParameter = "󰅲",
      }
      vim_item.kind = string.format("%s %s", icons[vim_item.kind] or "", vim_item.kind)
      return vim_item
    end,
  },
  experimental = {
    ghost_text = true, -- The "grayed out" suggestion like Copilot/VS Code
  },
})
