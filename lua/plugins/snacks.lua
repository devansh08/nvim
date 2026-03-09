return {
  {
    "folke/snacks.nvim",
    branch = "main",
    -- Reference: https://github.com/folke/snacks.nvim?tab=readme-ov-file#-usage
    opts = {
      bigfile = {
        enabled = true,
      },
      quickfile = {
        enabled = true,
      },
      input = {
        enabled = true,
        icon = "",
      },
      picker = {
        enabled = true,
      },
      -- Reference: https://github.com/folke/snacks.nvim/blob/main/docs/styles.md#-styles-1
      styles = {
        input = {
          relative = "cursor",
          row = 1,
        },
      },
    },
  },
}
