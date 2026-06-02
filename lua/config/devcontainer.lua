require("devcontainer").setup({
  -- optional customization
  generate_commands = true,
<<<<<<< Updated upstream
  autocommands = {
    init = false,
    clean = false,
  },
  attach_mounts = {
    container_runtime = "docker",  -- or nil to autodetect
  },
})
=======
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
>>>>>>> Stashed changes
