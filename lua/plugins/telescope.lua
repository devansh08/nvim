return {
  {
    "nvim-telescope/telescope-dap.nvim",
    branch = "master",
    lazy = true,
    cmd = { "DapContinue", "DapNew", "DapToggleBreakpoint" },
  },
  {
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-fzf-native.nvim",
    branch = "main",
    build = "make",
  },
  {
    branch = "master",
    dependencies = {
      "nvim-telescope/telescope-dap.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local actions_set = require("telescope.actions.set")

      local default_keymaps = {
        ["<C-Up>"] = function(bufnr)
          actions_set.shift_selection(bufnr, -3)
        end,
        ["<C-Down>"] = function(bufnr)
          actions_set.shift_selection(bufnr, 3)
        end,
        ["<C-S-Up>"] = actions.preview_scrolling_up,
        ["<C-S-Down>"] = actions.preview_scrolling_down,
        ["<C-S-Left>"] = actions.preview_scrolling_left,
        ["<C-S-Right>"] = actions.preview_scrolling_right,

        ["<S-Up>"] = actions.cycle_history_prev,
        ["<S-Down>"] = actions.cycle_history_next,

        ["<C-c>"] = actions.close,
      }
      local custom_keymaps = {
        i = {
          ["<CR>"] = actions.select_default,
          ["<C-T>"] = actions.select_tab_drop,
        },
        n = {
          ["<CR>"] = actions.select_default,
          ["<C-T>"] = actions.select_tab_drop,
        },
      }

      telescope.setup({
        defaults = {
          layout_strategy = "horizontal",
          layout_config = {
            scroll_speed = 1,
            horizontal = {
              height = 0.8,
              width = 0.9,
              preview_width = 0.5,
            },
          },
          path_display = {
            shorten = {
              len = 1,
              exclude = { -1, -2, -3 },
            },
          },
          dynamic_preview_title = true,
          mappings = {
            n = default_keymaps,
            i = default_keymaps,
          },
        },
        pickers = {
          find_files = {
            find_command = {
              "rg",
              "--files",
              "--color=never",
              "--follow",
              "--hidden",
              "--ignore",
              "--smart-case",
              "--sort=modified",
              "--glob=!**/.git/*",
            },
            hidden = true,
            mappings = custom_keymaps,
          },
          live_grep = {
            mappings = custom_keymaps,
            additional_args = function(_)
              return {
                "--hidden",
                "--smart-case",
                "--glob=!**/.git/*",
              }
            end,
            sorting_strategy = "ascending",
          },
          jumplist = {
            show_line = false,
          },
          buffers = {
            sort_mru = true,
          },
          lsp_references = {
            jump_type = "never",
            show_line = false,
            mappings = custom_keymaps,
          },
          lsp_implementations = {
            jump_type = "never",
            reuse_win = true,
            show_line = false,
            mappings = custom_keymaps,
          },
          lsp_definitions = {
            jump_type = "never",
            reuse_win = true,
            show_line = false,
            mappings = custom_keymaps,
          },
          diagnostics = {
            mappings = custom_keymaps,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })

      telescope.load_extension("refactoring")
      telescope.load_extension("dap")
      telescope.load_extension("fzf")
    end,
  },
}
