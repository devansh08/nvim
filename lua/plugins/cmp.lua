return {
  {
    "rafamadriz/friendly-snippets",
    branch = "main",
    lazy = true,
  },
  {
    "L3MON4D3/LuaSnip",
    version = "*",
    lazy = true,
    build = "make install_jsregexp",
    config = function()
      -- Lua snippets example: https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua#L190
      require("luasnip.loaders.from_lua").lazy_load({
        paths = require("constants").NVIM_CONFIG .. "/snippets",
      })
    end,
  },
  {
    "onsails/lspkind.nvim",
    branch = "master",
    lazy = true,
  },
  {
    "saghen/blink.cmp",
    version = "*",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "L3MON4D3/LuaSnip",
      "onsails/lspkind.nvim",
    },
    -- https://cmp.saghen.dev/configuration/reference.html
    config = function()
      local utils = require("utils")
      local mocha = require("catppuccin.palettes").get_palette("mocha")
      utils.highlight("BlinkCmpMenu", mocha["text"], mocha["base"])
      utils.highlight("BlinkCmpMenuBorder", mocha["blue"], mocha["base"])
      utils.highlight("BlinkCmpDoc", mocha["text"], mocha["base"])
      utils.highlight("BlinkCmpDocBorder", mocha["blue"], mocha["base"])
      utils.highlight("BlinkCmpDocSeparator", mocha["blue"], mocha["base"])
      utils.highlight("BlinkCmpSignatureHelp", mocha["text"], mocha["base"])
      utils.highlight("BlinkCmpSignatureHelpBorder", mocha["blue"], mocha["base"])
      utils.highlight("BlinkCmpSignatureHelpActiveParameter", mocha["text"], mocha["overlay0"])

      require("blink.cmp").setup({
        enabled = function()
          return true
        end,
        keymap = {
          preset = "none",
          ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
          ["<C-c>"] = { "cancel", "fallback" },
          ["<Esc>"] = { "cancel", "fallback" },
          ["<CR>"] = { "select_and_accept", "fallback" },
          ["<Tab>"] = { "select_and_accept", "snippet_forward", "fallback" },
          ["<S-Tab>"] = { "snippet_backward", "fallback" },
          ["<Up>"] = { "select_prev", "fallback" },
          ["<Down>"] = { "select_next", "fallback" },
          ["<Right>"] = { "select_and_accept", "fallback" },
          ["<C-S-Up>"] = {
            function(cmp)
              cmp.scroll_documentation_up(3)
            end,
            "fallback",
          },
          ["<C-S-Down>"] = {
            function(cmp)
              cmp.scroll_documentation_down(3)
            end,
            "fallback",
          },
        },
        appearance = {
          nerd_font_variant = "mono",
        },
        completion = {
          keyword = {
            range = "prefix",
          },
          trigger = {
            show_on_backspace = false,
            show_on_backspace_in_keyword = false,
            show_on_backspace_after_accept = true,
            show_on_backspace_after_insert_enter = true,
            show_on_trigger_character = true,
            show_on_insert_on_trigger_character = true,
            show_on_blocked_trigger_characters = {
              " ",
              "\n",
              "\t",
            },
            show_on_x_blocked_trigger_characters = {
              "'",
              '"',
              "(",
            },
          },
          list = {
            selection = {
              preselect = false,
              auto_insert = false,
            },
            cycle = {
              from_bottom = true,
              from_top = true,
            },
          },
          menu = {
            enabled = true,
            min_width = 15,
            max_height = 12,
            border = "single",
            winblend = 0,
            scrolloff = 2,
            scrollbar = true,
            direction_priority = { "s", "n" },
            auto_show = false,
            draw = {
              align_to = "label",
              padding = 1,
              gap = 1,
              columns = {
                { "kind_icon" },
                { "label" },
                { "source_name" },
              },
              components = {
                kind_icon = {
                  text = function(ctx)
                    local icon = ctx.kind_icon
                    if vim.tbl_contains({ "Path" }, ctx.source_name) then
                      local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                      if dev_icon then
                        icon = dev_icon
                      end
                    else
                      icon = require("lspkind").symbolic(ctx.kind, {
                        mode = "symbol",
                      })
                    end
                    return icon .. ctx.icon_gap
                  end,
                  highlight = function(ctx)
                    local hl = ctx.kind_hl
                    if vim.tbl_contains({ "Path" }, ctx.source_name) then
                      local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                      if dev_icon then
                        hl = dev_hl
                      end
                    end
                    return hl
                  end,
                },
              },
            },
          },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 250,
            treesitter_highlighting = true,
            window = {
              min_width = 10,
              max_width = 80,
              max_height = 20,
              border = "single",
              scrollbar = true,
              direction_priority = {
                menu_north = { "e", "w", "n", "s" },
                menu_south = { "e", "w", "s", "n" },
              },
            },
          },
          ghost_text = {
            enabled = GetIcon,
          },
          accept = {
            dot_repeat = true,
            create_undo_point = true,
            resolve_timeout_ms = 100,
            auto_brackets = {
              enabled = true,
              default_brackets = { "(", ")" },
              kind_resolution = {
                enabled = true,
                blocked_filetypes = { "typescriptreact", "javascriptreact", "vue" },
              },
              semantic_token_resolution = {
                enabled = true,
                blocked_filetypes = { "java" },
                timeout_ms = 250,
              },
            },
          },
        },
        sources = {
          default = {
            "lsp",
            "path",
            "snippets",
            "buffer",
          },
        },
        snippets = {
          preset = "luasnip",
        },
        fuzzy = {
          implementation = "prefer_rust_with_warning",
          use_frecency = true,
          use_proximity = true,
          sorts = {
            "score",
            "sort_text",
          },
        },
        signature = {
          enabled = true,
          trigger = {
            enabled = true,
            show_on_keyword = false,
            show_on_trigger_character = true,
            show_on_insert = false,
            show_on_insert_on_trigger_character = true,
          },
          window = {
            min_width = 1,
            max_width = 100,
            max_height = 10,
            border = "single",
            scrollbar = false,
            direction_priority = { "n", "s" },
            treesitter_highlighting = true,
            show_documentation = false,
          },
        },
        cmdline = {
          enabled = true,
          sources = {
            "cmdline",
          },
          keymap = {
            ["<Tab>"] = { "show_and_insert" },
            ["<Space>"] = { "select_and_accept", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },
            ["<Up>"] = { "select_prev", "fallback" },
            ["<CR>"] = { "select_accept_and_enter", "fallback" },
            ["<C-c>"] = { "cancel", "fallback" },
          },
          completion = {
            list = {
              selection = {
                preselect = true,
                auto_insert = true,
              },
            },
            menu = {
              auto_show = false,
            },
            ghost_text = {
              enabled = false,
            },
          },
        },
        term = {
          enabled = false,
        },
      })
    end,
  },
}
