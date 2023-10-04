return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    dependencies = {
      {
        "nvim-telescope/telescope-ui-select.nvim",
        branch = "master",
        lazy = true,
      },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      local custom_keymaps = {
        i = {
          ["<CR>"] = actions.select_tab_drop,
          ["<C-T>"] = actions.select_default,
        },
        n = {
          ["<CR>"] = actions.select_tab_drop,
          ["<C-T>"] = actions.select_default,
        },
      }

      telescope.setup({
        defaults = {
          path_display = {
            shorten = {
              len = 1,
              exclude = { -1, -2, -3 },
            },
          },
          dynamic_preview_title = true,
          mappings = {
            n = {
              ["<C-Up>"] = actions.preview_scrolling_up,
              ["<C-Down>"] = actions.preview_scrolling_down,

              ["<C-c>"] = actions.close,
            },
            i = {
              ["<C-Up>"] = actions.preview_scrolling_up,
              ["<C-Down>"] = actions.preview_scrolling_down,

              ["<C-c>"] = actions.close,
            },
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
          },
          jumplist = {
            show_line = false,
          },
          buffers = {
            sort_mru = true,
          },
          git_commits = {
            git_command = {
              "git",
              "log",
              "--format=%h %s %d",
            },
          },
          git_bcommits = {
            git_command = {
              "git",
              "log",
              "--format=%h %s %d",
            },
          },
          git_bcommits_range = {
            git_command = {
              "git",
              "log",
              "--format=%h %s %d",
              "--no-patch",
              "-L",
            },
          },

        },
        extensions = {
          ["ui-select"] = {},
        },
      })

      telescope.load_extension("ui-select")
    end,
  },
}
