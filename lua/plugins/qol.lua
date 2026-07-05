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
      image = {
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
  {
    "folke/trouble.nvim",
    branch = "main",
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
  {
    "catgoose/nvim-colorizer.lua",
    branch = "master",
    lazy = true,
    ft = { "css", "scss", "html" },
    -- Reference: https://github.com/catgoose/nvim-colorizer.lua?tab=readme-ov-file#customization
    opts = {
      filetypes = { "css", "scss", "html" },
      user_default_options = {
        mode = "virtualtext",
        always_update = true,
        css = true,
        css_fn = true,
        tailwind = true,
        sass = { enable = true, parsers = { "css" } },
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    branch = "main",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    -- Reference: https://github.com/folke/todo-comments.nvim?tab=readme-ov-file#%EF%B8%8F-configuration
    opts = {
      keywords = {
        FIX = {
          icon = " ",
          color = "error",
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
        },
        TODO = { icon = " ", color = "info", alt = { "TRY", "EXPLORE" } },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "󰤑 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
    },
  },
  {
    "folke/zen-mode.nvim",
    tag = "stable",
    lazy = true,
    cmd = "ZenMode",
    -- Reference: https://github.com/folke/zen-mode.nvim?tab=readme-ov-file#%EF%B8%8F-configuration
    opts = {
      window = {
        backdrop = 0.75,
        width = 0.60,
        height = 1,
        options = {
          signcolumn = "yes",
          foldcolumn = "0",
          list = false,
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
          laststatus = 0,
          winborder = "single",
        },
        twilight = { enabled = false },
        gitsigns = { enabled = true },
      },
    },
  },
  {
    "stevearc/quicker.nvim",
    version = "*",
    lazy = true,
    ft = "qf",
    opts = {
      keys = {
        {
          ">",
          function()
            require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
          end,
          desc = "Quicker: Expand Context",
        },
        {
          "<",
          function()
            require("quicker").collapse()
          end,
          desc = "Quicker: Collapse Context",
        },
      },
    },
  },
}
