return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    tag = "stable",
    pritority = 1000,
    -- Reference: https://github.com/catppuccin/nvim?tab=readme-ov-file#configuration
    config = function()
      vim.g.catppuccin_flavour = "mocha"

      require("catppuccin").setup({
        flavour = vim.g.catppuccin_flavour,
        background = {
          dark = vim.g.catppuccin_flavour,
        },
        term_colors = true,
        styles = {
          conditionals = {},
        },
        integrations = {
          nvimtree = true,
          gitsigns = true,
          telescope = true,
          mason = true,
          treesitter = true,
          treesitter_context = true,
          rainbow_delimiters = true,
          fidget = true,
          lsp_trouble = true,
          snacks = {
            enabled = true,
          },
        },
        highlight_overrides = {
          [vim.g.catppuccin_flavour] = function(f)
            local darken = require("catppuccin.utils.colors").darken

            return {
              LspReferenceRead = { bg = f.surface2 },
              LspReferenceWrite = { bg = f.surface2 },
              LspReferenceText = { bg = f.surface2 },

              DiffAdd = { bg = darken(f.green, 0.25, f.base) },
              DiffChange = { bg = darken(f.blue, 0.15, f.base) },
              DiffDelete = { bg = darken(f.red, 0.25, f.base) },
              DiffText = { bg = darken(f.blue, 0.30, f.base) },

              SnacksInputBorder = { fg = f.blue },
              SnacksInputTitle = { fg = f.blue, style = {} },
            }
          end,
        },
      })

      vim.cmd([[ colorscheme catppuccin ]])
    end,
  },
}
