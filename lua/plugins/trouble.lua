return {
  {
    "folke/trouble.nvim",
    tag = "stable",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    -- Reference: https://github.com/folke/trouble.nvim?tab=readme-ov-file#%EF%B8%8F-configuration
    opts = {
      auto_preview = false,
      focus = true,
      open_no_results = true,
      win = {
        type = "split",
        relative = "win",
        size = {
          height = 10,
        },
        position = "bottom",
      },
      keys = {
        ["<c-s>"] = false,
        ["<c-x>"] = "jump_split",
      },
      modes = {
        diagnostics = {
          win = {
            type = "split",
            relative = "win",
            position = "bottom",
            size = {
              height = 2,
            },
          },
        },
        symbols = {
          win = {
            position = "right",
            relative = "win",
            size = {
              width = 40,
            },
          },
        },
      },
    },
  },
}
