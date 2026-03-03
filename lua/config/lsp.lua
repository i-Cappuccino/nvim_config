-- 1. Shared On-Attach: Keymaps for all languages
local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }
  
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "K",  vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, opts)
end

-- 2. Capabilities for Autocompletion
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- 3. Define and enable servers natively
-- Instead of lspconfig[name].setup, we use vim.lsp.config
local servers = {
  clangd = {
    cmd = { "clangd", "--background-index", "--clang-tidy" },
    -- Native root_dir detection
    root_markers = { ".git", "compile_commands.json", "build/compile_commands.json" },
  },
  pyright = {
    cmd = { "pyright-langserver", "--stdio" },
    root_markers = { ".git", "pyproject.toml", "setup.py" },
  },
  lua_ls = {
    cmd = { "lua-language-server" },
    root_markers = { ".git", ".luarc.json" },
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = { checkThirdParty = false },
      },
    },
  },
}

-- 4. Enable the servers
for name, config in pairs(servers) do
  config.capabilities = capabilities
  -- Apply the on_attach via an autocmd (the 0.11 native way)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and client.name == name then
        on_attach(client, args.buf)
      end
    end,
  })
  
  -- The core call that replaces the old lspconfig framework
  vim.lsp.config(name, config)
  vim.lsp.enable(name)
end
