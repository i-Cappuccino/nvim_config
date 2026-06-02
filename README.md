# Neovim + Tmux Config — v2 (fixes + optimizations)

## What changed in this version

### Bug fix: the cmp circular-require error you hit

`Failed to run config for nvim-cmp: loop or previous error loading module 'config.cmp'`

This was a classic lazy.nvim trap. Both `nvim-cmp` and `nvim-autopairs` had `event = "InsertEnter"`. When you entered insert mode:

1. lazy started loading nvim-autopairs
2. autopairs's config did `require("cmp")`
3. lazy intercepted: "need to load nvim-cmp first" — started loading it
4. nvim-cmp's config did `require("config.cmp")`
5. config/cmp.lua line 1 did `require("cmp")` — but cmp was **still mid-load** from step 2
6. Lua throws `loop or previous error`

**Fix:** Added `dependencies = { "hrsh7th/nvim-cmp" }` to nvim-autopairs in plugins.lua. Now lazy guarantees nvim-cmp is **fully** loaded before autopairs config runs, so the `require("cmp")` inside autopairs just returns the cached module.

### Other improvements

| Change | Why |
|--------|-----|
| `<leader>f` no longer = format | It conflicted with `<leader>fX` find prefix, forcing a 300ms wait every time you tried to find a file. Format moved to `<leader>cf`. |
| Added `flash.nvim` | `s<char><char>` then a label jumps you anywhere visible. The single biggest motion upgrade you can make. |
| Added clangd header/source switch | `<leader>ch` flips `foo.cpp` ↔ `foo.h` — VS Code clangd extension parity. |
| `cmp-nvim-lsp` promoted to top-level plugin entry | So lspconfig can load it even when nvim-cmp hasn't been triggered. |
| Better clangd args | IWYU header insertion, function arg placeholders, detailed completion. |
| Lazier loading | `nvim-tree`, `telescope`, `toggleterm`, `devcontainer` now load on command (faster startup). |
| Version guard in lsp.lua | Loud error if you're on a Neovim that's too old for `vim.lsp.config`. |
| `pcall` safety belt in autopairs | Belt-and-suspenders so it never re-breaks the same way. |

---

## Install

```bash
# Backup
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.tmux.conf  ~/.tmux.conf.bak 2>/dev/null

# Place files
mkdir -p ~/.config/nvim/lua/config
cp init.lua            ~/.config/nvim/
cp lua/plugins.lua     ~/.config/nvim/lua/
cp lua/config/*.lua    ~/.config/nvim/lua/config/
cp tmux.conf           ~/.tmux.conf

# Important — wipe stale plugin state (the cmp error may have left a half-loaded state)
rm -rf ~/.local/share/nvim/lazy
rm -rf ~/.local/state/nvim/lazy

# Reload tmux if attached
tmux source ~/.tmux.conf 2>/dev/null

# Open Neovim — lazy.nvim auto-installs everything fresh
nvim

# After plugins install, install formatters once:
:MasonInstall stylua ruff black clang-format prettier shfmt
```

**Requires Neovim ≥ 0.11.** Check with `nvim --version`. On macOS: `brew upgrade neovim`.

---

## Key Bindings (updated)

### Navigation (Caps Lock = Ctrl)
| Key | Action |
|-----|--------|
| `Ctrl+h/j/k/l` | Move between Neovim splits AND Tmux panes |
| `Shift+h/l` | Prev/next buffer |
| `s<c1><c2>` + label | **Flash jump** anywhere visible (new!) |
| `S` | Flash jump by treesitter node |
| `Ctrl+\` | Toggle floating terminal |

### Code (`<leader>c` prefix, was conflicting `<leader>f`)
| Key | Action |
|-----|--------|
| `<leader>cf` | **Format file** (was `<leader>f`) |
| `<leader>ca` | Code actions |
| `<leader>cr` | Rename symbol |
| `<leader>ch` | **Header ↔ Source** (clangd only, new!) |

### Find (`<leader>f` prefix — now unconflicted)
| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>fr` | Recent files |
| `<leader>fw` | Word under cursor |
| `<leader>fs` | Document symbols |
| `<leader>ft` | TODOs |

### LSP
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | References |
| `K` | Hover docs |
| `Ctrl+s` | Signature help |
| `[d` / `]d` | Prev/next diagnostic |

### Git
| Key | Action |
|-----|--------|
| `<leader>gg` | LazyGit |
| `<leader>gb` | Blame line |
| `<leader>gd` | Diff this |
| `<leader>gs` | Stage hunk |
| `]g` / `[g` | Next/prev hunk |

### Editing
| Key | Action |
|-----|--------|
| `Alt+j/k` | Move line(s) down/up |
| `gcc` | Toggle line comment |
| `gc` (visual) | Toggle comment on selection |
| `ysiw"` | Surround word with quotes |
| `cs"'` | Change `"` to `'` |
| `ds"` | Delete surrounding `"` |
| `Ctrl+Space` | Expand treesitter selection |

---

## C++ workflow (Conan/DDS)

Your stack should now have everything:

- **clangd** with IWYU, clang-tidy, function arg placeholders
- **`<leader>ch`** swaps header/source
- **`compile_commands.json` autodetection** — clangd will find `build/compile_commands.json` automatically. With Conan, run `conan build .` once to generate it; clangd picks it up on next file open.
- **`.clangd` config files** are now recognized as project roots
- **Format on save** disabled for C/C++ **unless** a `.clang-format` exists in the project (so your team's style sticks)

If clangd can't find headers, check that `compile_commands.json` exists at the repo root or in `build/`. Symlinking it to repo root is common: `ln -s build/compile_commands.json .`

---

## Committing to Vim motions

The fastest reps to internalize, in order:

1. **`5j`, `12k`** — with relative numbers on, line jumps are trivial
2. **`f<char>` + `;`** — jump to a character in the line; `;` to repeat
3. **`s<c1><c2>` + label** — flash jump anywhere on screen (this replaces ALL clicking)
4. **`ci(`, `ca"`, `ci{`** — change inside/around delimiters
5. **`Ctrl+o` / `Ctrl+i`** — jump back/forward through cursor history (VS Code Alt+Left/Right)
6. **`%`** — jump to matching bracket
7. **`*`** — search for word under cursor

Once `s` and `ci(` are in muscle memory, you'll be faster than VS Code.
