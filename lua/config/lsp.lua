<<<<<<< Updated upstream
vim.lsp.enable('lua_ls')
vim.lsp.enable('pyright')
vim.lsp.enable('clangd')
=======
-- lsp.lua — uses the native vim.lsp.config / vim.lsp.enable API (Neovim 0.11+)

---------------------------------------------------------------------------
-- 0. Version guard — fail loud if running on an older Neovim
---------------------------------------------------------------------------
if vim.fn.has("nvim-0.11") == 0 then
  vim.notify(
    "lsp.lua requires Neovim 0.11+ for vim.lsp.config/enable.\n" ..
    "Upgrade Neovim (brew upgrade neovim) or fall back to the legacy lspconfig setup.",
    vim.log.levels.ERROR
  )
  return
end

---------------------------------------------------------------------------
-- 1. Capabilities — tells servers what Neovim supports (completion, snippets)
---------------------------------------------------------------------------
local capabilities = require("cmp_nvim_lsp").default_capabilities()

---------------------------------------------------------------------------
-- 2. Single LspAttach handler for ALL servers
---------------------------------------------------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end

    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true, desc = desc })
    end

    -- Navigation
    map("n", "gd",   vim.lsp.buf.definition,      "Go to definition")
    map("n", "gD",   vim.lsp.buf.declaration,     "Go to declaration")
    map("n", "gi",   vim.lsp.buf.implementation,  "Go to implementation")
    map("n", "gt",   vim.lsp.buf.type_definition, "Type definition")
    map("n", "K",    vim.lsp.buf.hover,           "Hover docs")
    map("n", "<C-s>", vim.lsp.buf.signature_help, "Signature help")

    -- Actions
    map("n", "<leader>rn", vim.lsp.buf.rename,      "Rename symbol")
    map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")

    -- Formatting is handled by conform.nvim (<leader>cf in keymaps.lua).
    -- This is a buffer-local fallback that uses raw LSP formatting.
    map("n", "<leader>lf",
      function() vim.lsp.buf.format({ async = true }) end,
      "LSP format (fallback)")

    -- ─── clangd-specific keybinds ──────────────────────────────────────────
    -- Switch between header and source file (foo.cpp ↔ foo.h)
    -- Equivalent to VS Code's clangd extension Alt+O
    if client.name == "clangd" then
      map("n", "<leader>ch", function()
        local params = { uri = vim.uri_from_bufnr(bufnr) }
        client.request("textDocument/switchSourceHeader", params, function(err, result)
          if err then
            vim.notify("clangd: " .. err.message, vim.log.levels.ERROR)
            return
          end
          if not result then
            vim.notify("No corresponding header/source file", vim.log.levels.INFO)
            return
          end
          vim.cmd("edit " .. vim.uri_to_fname(result))
        end, bufnr)
      end, "Switch header/source (clangd)")
    end

    -- ─── Document highlights (VS Code "same-symbol" highlight) ────────────
    if client:supports_method("textDocument/documentHighlight") then
      local hl_grp = vim.api.nvim_create_augroup("UserLspHighlight_" .. bufnr, { clear = true })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = hl_grp, buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd("CursorMoved", {
        group = hl_grp, buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

---------------------------------------------------------------------------
-- 3. Diagnostic appearance
---------------------------------------------------------------------------
vim.diagnostic.config({
  virtual_text = { prefix = "●", spacing = 4 },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN]  = " ",
      [vim.diagnostic.severity.HINT]  = " ",
      [vim.diagnostic.severity.INFO]  = " ",
    },
  },
  underline       = true,
  update_in_insert = false,
  severity_sort   = true,
  float = { border = "rounded", source = true },
})

---------------------------------------------------------------------------
-- 4. Server definitions
---------------------------------------------------------------------------
local servers = {
  clangd = {
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--fallback-style=llvm",
    },
    root_markers = { ".clangd", ".git", "compile_commands.json", "build/compile_commands.json", "CMakeLists.txt" },
    filetypes   = { "c", "cpp", "objc", "objcpp" },
    -- Tell cmp that clangd supports snippets for arg placeholders
    capabilities = vim.tbl_deep_extend("force", capabilities, {
      textDocument = { completion = { editsNearCursor = true } },
      offsetEncoding = { "utf-16" },
    }),
  },

  pyright = {
    cmd = { "pyright-langserver", "--stdio" },
    root_markers = { ".git", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt" },
    filetypes = { "python" },
    settings = {
      python = {
        analysis = {
          autoSearchPaths      = true,
          useLibraryCodeForTypes = true,
          typeCheckingMode     = "basic",
        },
      },
    },
  },

  lua_ls = {
    cmd = { "lua-language-server" },
    root_markers = { ".git", ".luarc.json", ".luarc.jsonc" },
    filetypes = { "lua" },
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = {
          checkThirdParty = false,
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = { enable = false },
      },
    },
  },
}

---------------------------------------------------------------------------
-- 5. Register and enable
---------------------------------------------------------------------------
for name, config in pairs(servers) do
  -- Apply capabilities unless the server already set its own
  if not config.capabilities then config.capabilities = capabilities end
  vim.lsp.config(name, config)
  vim.lsp.enable(name)
end
>>>>>>> Stashed changes
