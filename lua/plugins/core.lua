return {
  {
    "folke/lazy.nvim",
    tag = "stable",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "rmagatti/auto-session",
    branch = "main",
    priority = 1001,
    dependencies = {
      "nvim-tree/nvim-tree.lua",
      "nvim-lua/plenary.nvim",
    },
    -- Reference: https://github.com/rmagatti/auto-session?tab=readme-ov-file#%EF%B8%8F-configuration
    config = function()
      require("auto-session").setup({
        enabled = true,
        session_lens = {
          load_on_setup = false,
        },
      })

      vim.o.sessionoptions = "buffers,curdir,tabpages,winsize,winpos,localoptions"
    end,
  },
}
