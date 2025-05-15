return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    branch = "master",
    lazy = true,
    event = "BufReadPost",
    config = function()
      local opts = {
        enable = true,
        line_numbers = true,
        max_lines = 2,
        trim_scope = "outer",
      }

      require("treesitter-context").setup(opts)
    end,
  },
  {
    "hiphish/rainbow-delimiters.nvim",
    branch = "master",
    lazy = true,
    event = "BufReadPost",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
          javascript = "rainbow-delimiters-ract",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    version = "*",
    lazy = true,
    event = "BufReadPost",
    main = "ibl",
    config = function()
      local highlight = {
        "RainbowDelimiterRed",
        "RainbowDelimiterYellow",
        "RainbowDelimiterBlue",
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
        "RainbowDelimiterViolet",
        "RainbowDelimiterCyan",
      }
      local hooks = require("ibl.hooks")

      vim.g.rainbow_delimiters = { highlight = highlight }
      require("ibl").setup({
        indent = {
          char = " ",
        },
        scope = {
          enabled = true,
          char = "│",
          show_start = false,
          show_end = false,
          show_exact_scope = false,
          highlight = highlight,
        },
        exclude = {
          filetypes = { "dart" },
        },
      })

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    branch = "main",
    lazy = true,
    event = "BufWritePre",
    config = function()
      local opts = {
        autotag = {
          enable = true,
          enable_rename = true,
          enable_close = true,
          enable_close_on_slash = true,
        },
      }

      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "master",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local opts = {
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["as"] = "@block.outer",
              ["is"] = "@block.inner",
              ["ap"] = "@parameter.outer",
              ["ip"] = "@parameter.inner",
            },
            include_surrounding_whitespace = true,
          },
          move = {
            enable = true,
            set_jumps = false,
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]s"] = "@block.outer",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]S"] = "@block.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[s"] = "@block.outer",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[S"] = "@block.outer",
            },
          },
        },
      }

      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    version = "*",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync" },
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "hiphish/rainbow-delimiters.nvim",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      local utils = require("utils")
      local check_executable = utils.check_executable

      local opts = {
        ensure_installed = check_executable({
          ["bash"] = { { "bash" } },
          ["c"] = { { "gcc" } },
          ["cpp"] = { { "g++" } },
          ["css"] = {},
          ["dart"] = { { "dart" } },
          ["dockerfile"] = { { "docker" }, { "pulumi" } },
          ["fish"] = { { "fish" } },
          ["go"] = { { "go" } },
          ["html"] = {},
          ["java"] = { { "java" } },
          ["javascript"] = { { "node", "npm" }, { "bun" } },
          ["jsdoc"] = { { "node", "npm" }, { "bun" } },
          ["json"] = {},
          ["json5"] = {},
          ["jsonc"] = {},
          ["kotlin"] = { { "kotlin" } },
          ["lua"] = { { "lua" } },
          ["markdown"] = {},
          ["python"] = { { "python", "pip" } },
          ["rust"] = { { "rustc" } },
          ["scss"] = {},
          ["sql"] = { { "mysql" } },
          ["toml"] = {},
          ["tsx"] = { { "node", "npm" }, { "bun" } },
          ["typescript"] = { { "node", "npm" }, { "bun" } },
          ["vim"] = {},
          ["vimdoc"] = {},
          ["yaml"] = {},
          ["zig"] = { { "zig" } },
        }),
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
          -- HACK: https://github.com/nvim-treesitter/nvim-treesitter/issues/4945
          -- https://github.com/UserNobody14/tree-sitter-dart/issues/60#issuecomment-1867049690
          disable = { "dart" },
        },
        autopairs = {
          enable = true,
          disable = { "dart" },
        },
        context_commentstring = {
          enable = true,
          disable = { "dart" },
        },
      }

      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    branch = "main",
    lazy = true,
    event = "BufWritePre",
  },
}
