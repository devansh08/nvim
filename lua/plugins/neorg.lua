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
          ["core.clipboard"] = {},
          ["core.clipboard.code-blocks"] = {},
          ["core.concealer"] = {
            config = {
              folds = true,
              icon_preset = "diamond",
              icons = {
                code_block = {
                  conceal = true,
                  content_only = true,
                  padding = {
                    left = 2,
                    right = 2,
                  },
                  width = "fullwidth",
                },
              },
            },
          },
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
          ["core.esupports.hop"] = {
            config = {
              lookahead = true,
            },
          },
          ["core.esupports.indent"] = {
            config = {
              dedent_excess = true,
              format_on_enter = true,
              format_on_escape = true,
            },
          },
          ["core.integrations.nvim-cmp"] = {},
          ["core.integrations.treesitter"] = {
            config = {
              configure_parsers = true,
              install_parsers = true,
            },
          },
          ["core.itero"] = {},
          ["core.promo"] = {},
        },
      })
    end,
  },
}
