return {
  {
    "folke/lazydev.nvim",
    version = "*",
    cond = function(_)
      return require("utils").file_exists_in_root(".enable-neodev")
    end,
    ft = "lua",
    dependencies = {
      "Bilal2453/luvit-meta",
    },
    opts = {
      library = {
        "~/.config/nvim",
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "Bilal2453/luvit-meta",
    branch = "main",
    lazy = true,
  },
}
