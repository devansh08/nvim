return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {
      enabled = true,
      render_modes = { "n", "c", "t" },
      anti_conceal = {
        enabled = true,
      },
    },
  },
}
