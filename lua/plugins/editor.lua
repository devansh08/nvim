return {
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    branch = "main",
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
  },
  {
    "numToStr/Comment.nvim",
    branch = "master",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    -- Reference: https://github.com/numToStr/Comment.nvim?tab=readme-ov-file#configuration-optional
    config = function()
      -- Config instead of opts required to correctly handle plugin load order: https://github.com/JoosepAlviste/nvim-ts-context-commentstring/issues/58#issuecomment-1589505282
      require("Comment").setup({
        mappings = {
          basic = false,
          extra = false,
        },
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },
  {
    "tpope/vim-abolish",
    branch = "master",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
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
    "axelvc/template-string.nvim",
    branch = "main",
    lazy = true,
    ft = { "html", "typescript", "javascript", "typescriptreact", "javascriptreact", "python" },
    -- Reference: https://github.com/axelvc/template-string.nvim?tab=readme-ov-file#configuration
    opts = {
      filetypes = {
        "html",
        "typescript",
        "javascript",
        "typescriptreact",
        "javascriptreact",
        "python",
      },
      remove_template_string = true,
      restore_quotes = {
        normal = [["]],
        jsx = [["]],
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
    "mbbill/undotree",
    branch = "master",
    config = function()
      vim.g.undotree_WindowLayout = 3
      vim.g.undotree_ShortIndicators = 1
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_SplitWidth = 40
    end,
  },
  {
    "mg979/vim-visual-multi",
    branch = "master",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    -- https://github.com/mg979/vim-visual-multi/issues/241#issuecomment-1575139717
    init = function()
      vim.g.VM_maps = {
        ["Add Cursor Down"] = "<M-j>",
        ["Add Cursor Up"] = "<M-k>",
        ["Select h"] = "<M-h>",
        ["Select l"] = "<M-l>",
      }
      vim.g.VM_custom_motions = {
        ["<Left>"] = "h",
        ["<Right>"] = "l",
        ["<Up>"] = "k",
        ["<Down>"] = "j",
      }
      vim.g.VM_theme = "sand"
      vim.g.VM_set_statusline = 1
      vim.g.VM_silent_exit = 1

      vim.api.nvim_create_autocmd("User", {
        pattern = "visual_multi_exit",
        callback = function()
          local apply = require("blink.cmp.keymap.apply")
          local keymaps = vim.api.nvim_buf_get_keymap(0, "i")
          for _, map in ipairs(keymaps) do
            if vim.startswith(map.desc, apply.DESC_PREFIX) then
              vim.keymap.del("i", map.lhs, { buffer = 0 })
            end
          end
          apply.keymap_to_current_buffer({
            ["<C-Space>"] = { "show" },
            ["<C-c>"] = { "cancel", "fallback" },
            ["<Esc>"] = { "cancel", "fallback" },
            ["<CR>"] = { "select_and_accept", "fallback" },
            ["<Tab>"] = { "select_and_accept", "snippet_forward", "fallback" },
            ["<S-Tab>"] = { "snippet_backward", "fallback" },
            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },
            ["<S-Up>"] = {
              function(cmp)
                cmp.scroll_documentation_up(3)
              end,
              "fallback",
            },
            ["<S-Down>"] = {
              function(cmp)
                cmp.scroll_documentation_down(3)
              end,
              "fallback",
            },
          })
        end,
      })
    end,
  },
  {
    "tommcdo/vim-exchange",
    branch = "master",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "ghostbuster91/nvim-next",
    branch = "main",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local utils = require("utils")
      local cmd_opts = require("constants").CMD_OPTS

      local set_keymaps = utils.set_keymaps
      local lua_fn = utils.lua_fn

      local builtins = require("nvim-next.builtins")

      local next = require("nvim-next").setup({
        default_mappings = {
          repeat_style = "original",
        },
        items = {
          builtins.f,
          builtins.t,
        },
      })

      local feed_keys_maps = {
        ["n"] = {
          { "[(", "])", "Next: Repeat Builtin " },
          { "[{", "]}", "Next: Repeat Builtin " },
        },
        ["v"] = {
          { "[(", "])", "Next: Repeat Builtin " },
          { "[{", "]}", "Next: Repeat Builtin " },
        },
      }

      for k, x in pairs(feed_keys_maps) do
        local mode = k
        local keys = x
        local keymaps = {}

        for _, y in pairs(keys) do
          local prev_key = y[1]
          local next_key = y[2]
          local desc = y[3]

          local prev_func, next_func = next.make_repeatable_pair(function(_)
            vim.api.nvim_feedkeys(prev_key, "n", true)
          end, function(_)
            vim.api.nvim_feedkeys(next_key, "n", true)
          end)

          keymaps[prev_key] = { lua_fn(prev_func), desc .. prev_key }
          keymaps[next_key] = { lua_fn(next_func), desc .. next_key }
        end

        set_keymaps(mode, keymaps, cmd_opts)
      end

      local gd_prev, gd_next = next.make_repeatable_pair(function(_)
        vim.cmd("Gitsigns nav_hunk prev wrap=false")
      end, function(_)
        vim.cmd("Gitsigns nav_hunk next wrap=false")
      end)

      local d_prev, d_next = next.make_repeatable_pair(function(_)
        vim.cmd("lua vim.diagnostic.jump({ count = -1, float = false })")
      end, function(_)
        vim.cmd("lua vim.diagnostic.jump({ count = 1, float = false })")
      end)

      local q_prev, q_next = next.make_repeatable_pair(function(_)
        vim.cmd("lua require('trouble').prev({ skip_groups = true, jump = true })")
      end, function(_)
        vim.cmd("lua require('trouble').next({ skip_groups = true, jump = true })")
      end)

      local keymaps = {
        ["[g"] = { lua_fn(gd_prev), "Next|Gitsigns: Jump to Prev Hunk" },
        ["]g"] = { lua_fn(gd_next), "Next|Gitsigns: Jump to Next Hunk" },
        ["[d"] = { lua_fn(d_prev), "Next|Diagnostics: Jump to Prev Diagnostic" },
        ["]d"] = { lua_fn(d_next), "Next|Diagnostics: Jump to Next Diagnostic" },
        ["[q"] = { lua_fn(q_prev), "Next|Trouble: Jump to Prev Trouble Diagnostic" },
        ["]q"] = { lua_fn(q_next), "Next|Trouble: Jump to Next Trouble Diagnostic" },
      }

      set_keymaps("n", keymaps, cmd_opts)
    end,
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
    "devansh08/goto-line.nvim",
    branch = "main",
    opts = {
      open_cmd = "drop",
      pre_jump = function()
        if vim.api.nvim_get_option_value("filetype", { buf = 0 }) == "toggleterm" then
          vim.cmd("ToggleTerm")
        end
      end,
    },
  },
  {
    "devansh08/bloat.nvim",
    branch = "main",
    config = function()
      local COLORS = require("catppuccin.palettes.mocha")
      require("bloat").setup({
        width = 0.75,
        height = 0.75,
        highlight = {
          fg = COLORS.base,
          bg = COLORS.blue,
        },
        border = "single",
        name_prefix = "Scratch",
      })
    end,
  },
  {
    "devansh08/alt-tab.nvim",
    branch = "main",
    opts = {},
  },
}
