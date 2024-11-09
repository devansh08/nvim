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
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0,
      })
    end,
  },
}
