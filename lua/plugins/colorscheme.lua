return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    tag = "stable",
    priority = 1000,
    cond = vim.g.active_colorscheme == "catppuccin",
    opts = {
      flavour = vim.g.active_colorscheme_variant,
      term_colors = true,
      styles = {
        conditionals = {},
      },
      integrations = {
        nvimtree = true,
        gitsigns = true,
        mason = true,
        treesitter = true,
        treesitter_context = true,
        rainbow_delimiters = true,
        fidget = true,
        lsp_trouble = true,
        snacks = {
          enabled = true,
        },
        render_markdown = true,
        neogit = true,
      },
      highlight_overrides = {
        ["mocha"] = function(f)
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
    },
  },
  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    version = "*",
    priority = 1000,
    cond = vim.g.active_colorscheme == "tokyonight",
    opts = {
      style = vim.g.active_colorscheme_variant,
      styles = {
        comments = { italic = true },
        keywords = { italic = false },
        functions = {},
        variables = {},
        sidebars = "dark",
        floats = "dark",
      },
      dim_inactive = true,
    },
  },
  {
    "everviolet/nvim",
    name = "evergarden",
    branch = "main",
    priority = 1000,
    cond = vim.g.active_colorscheme == "evergarden",
    opts = {
      theme = {
        variant = vim.g.active_colorscheme_variant,
        accent = vim.g.active_colorscheme_accent,
      },
      style = {
        search = { "italic", "reverse" },
        incsearch = { "italic", "reverse" },
        comment = { "italic" },
      },
      integrations = {
        blink_cmp = true,
        gitsigns = true,
        nvimtree = true,
        rainbow_delimiters = true,
      },
    },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    version = "*",
    priority = 1000,
    cond = vim.g.active_colorscheme == "rose-pine",
    opts = {
      variant = vim.g.active_colorscheme_variant,
      dark_variant = vim.g.active_colorscheme_variant,
      dim_inactive_windows = true,
      styles = {
        bold = false,
        italic = false,
        transparency = false,
      },
    },
  },
  {
    "gbprod/nord.nvim",
    name = "nord",
    branch = "main",
    priority = 1000,
    cond = vim.g.active_colorscheme == "nord",
  },
  {
    "ribru17/bamboo.nvim",
    name = "bamboo",
    branch = "master",
    priority = 1000,
    cond = vim.g.active_colorscheme == "bamboo",
    opts = {
      style = vim.g.active_colorscheme_variant,
      dim_inactive = true,
      code_style = {
        comments = { italic = true },
        conditionals = { italic = false },
        keywords = {},
        functions = {},
        namespaces = { italic = false },
        parameters = { italic = false },
        strings = {},
        variables = {},
      },
    },
  },
  {
    "yorumicolors/yorumi.nvim",
    name = "yorumi",
    branch = "main",
    priority = 1000,
    cond = vim.g.active_colorscheme == "yorumi",
  },
  {
    "EdenEast/nightfox.nvim",
    name = "nightfox",
    branch = "main",
    priority = 1000,
    cond = vim.g.active_colorscheme == "nightfox",
    config = function()
      require("nightfox").setup({
        options = {
          dim_inactive = true,
          styles = {
            comments = "italic",
          },
        },
        palettes = {
          all = require("nightfox.palette").load(vim.g.active_colorscheme_variant),
        },
      })
    end,
  },
  {
    "navarasu/onedark.nvim",
    name = "onedark",
    branch = "master",
    priority = 1000,
    cond = vim.g.active_colorscheme == "onedark",
    opts = {
      style = vim.g.active_colorscheme_variant,
    },
  },
  {
    "oxfist/night-owl.nvim",
    name = "nightowl",
    branch = "main",
    priority = 1000,
    cond = vim.g.active_colorscheme == "nightowl",
  },
  {
    "datsfilipe/vesper.nvim",
    name = "vesper",
    branch = "main",
    priority = 1000,
    cond = vim.g.active_colorscheme == "vesper",
    opts = {
      italics = {
        comments = true,
        keywords = false,
        functions = false,
        strings = false,
        variables = false,
      },
    },
  },
  {
    "ficcdaf/ashen.nvim",
    name = "ashen",
    branch = "main",
    priority = 1000,
    cond = vim.g.active_colorscheme == "ashen",
    opts = {
      style_presets = {
        italic_comments = true,
      },
    },
  },
  {
    "Aejkatappaja/cendre",
    name = "cendre",
    version = "*",
    priority = 1000,
    cond = vim.g.active_colorscheme == "cendre",
    opts = {
      background = vim.g.active_colorscheme_variant,
      dim_inactive = true,
      italic_comments = true,
    },
  },
  {
    "craftzdog/solarized-osaka.nvim",
    name = "solarized-osaka",
    branch = "main",
    priority = 1000,
    cond = vim.g.active_colorscheme == "solarized-osaka",
    opts = {
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = false },
        functions = {},
        variables = {},
        sidebars = "dark",
        floats = "dark",
      },
      sidebars = { "qf", "help" },
      dim_inactive = true,
    },
  },
  {
    "st-eez/osaka-jade.nvim",
    name = "osaka-jade",
    branch = "main",
    priority = 1000,
    cond = vim.g.active_colorscheme == "osaka-jade",
  },
  {
    "jpwol/thorn.nvim",
    name = "thorn",
    version = "*",
    priority = 1000,
    cond = vim.g.active_colorscheme == "thorn",
    opts = {
      theme = vim.g.active_colorscheme_variant,
      transparent = false,
      terminal = true,
      styles = {
        keywords = { italic = false, bold = false },
        comments = { italic = true, bold = false },
        strings = { italic = false, bold = false },
        diagnostic = {
          underline = true,
          error = { highlight = true },
          hint = { highlight = false },
          info = { highlight = false },
          warn = { highlight = false },
        },
      },
    },
  },
  {
    "uhs-robert/oasis.nvim",
    name = "oasis",
    version = "*",
    priority = 1000,
    cond = vim.g.active_colorscheme == "oasis",
    opts = {
      style = vim.g.active_colorscheme_variant,
      themed_syntax = true,
      styles = {
        bold = false,
        italic = true,
        underline = true,
        undercurl = true,
        strikethrough = true,
      },
      transparent = false,
      terminal_colors = true,
      match_paren_bg = false,
      integrations = {
        default_enabled = false,
        plugins = {
          gitsigns = true,
          lazy = true,
          render_markdown = true,
          snacks = true,
          trouble = true,
        },
      },
    },
  },
}
