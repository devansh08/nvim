return {
  {
    "folke/snacks.nvim",
    branch = "main",
    -- Reference: https://github.com/folke/snacks.nvim?tab=readme-ov-file#-usage
    opts = {
      bigfile = {},
      quickfile = {},
      input = {
        enabled = true,
        icon = "",
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
