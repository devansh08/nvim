return {
  {
    "nvim-neorg/neorg",
    version = "*",
    lazy = true,
    ft = { "norg" },
    cmd = "Neorg",
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.keybinds"] = {
            config = {
              default_keybinds = false,
            },
          },
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/Documents/Notes",
                todo = "~/Documents/Notes/ToDo",
              },
              default_workspace = "notes",
            },
          },
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp",
              name = "neorg",
            },
          },
        },
      })
    end,
  },
}
