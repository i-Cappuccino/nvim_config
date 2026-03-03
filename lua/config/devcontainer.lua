require("devcontainer").setup({
  generate_commands = true,
  autocommands = {
    init = true, -- Changed to true so it sets up commands on startup
    clean = true,
  },
  attach_mounts = {
    neovim_config = {
      enabled = true,
      type = "bind", -- Mounts your ~/.config/nvim into the container
    },
    neovim_data = {
      enabled = true,
      type = "bind",
    },
    container_runtime = "docker",
  },
  -- This is the magic part for your Conan/DDS headers
  callbacks = {
    on_container_start = function()
      print("Devcontainer started: Ready for Docker-based LSP")
    end,
  },
})
