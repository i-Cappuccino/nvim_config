require("devcontainer").setup({
  generate_commands = true,
  autocommands = { init = true, clean = true },
  attach_mounts = {
    neovim_config = { enabled = true, type = "bind" },
    neovim_data   = { enabled = true, type = "bind" },
    container_runtime = "docker",
  },
  callbacks = {
    on_container_start = function()
      vim.notify("Devcontainer started: Docker-based LSP ready", vim.log.levels.INFO)
    end,
  },
})
