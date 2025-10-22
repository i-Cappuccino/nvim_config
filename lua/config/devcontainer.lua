require("devcontainer").setup({
  -- optional customization
  generate_commands = true,
  autocommands = {
    init = false,
    clean = false,
  },
  attach_mounts = {
    container_runtime = "docker",  -- or nil to autodetect
  },
})