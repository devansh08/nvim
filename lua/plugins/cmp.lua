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
    build = function()
      local constants = require("constants")
      local blink = require("blink.cmp")

      local lspCapabilitiesFilePath = constants.NVIM_LOCAL .. "/blink/lsp_capabilities.lua"
      local lspCapabilitiesFile = io.open(lspCapabilitiesFilePath, "w")

      local capabilities = blink.get_lsp_capabilities({}, false)

      if lspCapabilitiesFile ~= nil then
        lspCapabilitiesFile:write("return " .. vim.inspect(capabilities))
        lspCapabilitiesFile:close()
      else
        print("[blink.cmp] Failed to save capabilities to " .. lspCapabilitiesFilePath)
      end
    end,
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

      -- Reference: https://cmp.saghen.dev/configuration/reference.html
      require("blink.cmp").setup({
        enabled = function()
          return true
        end,
        -- Any change needs to be reflected in vim-visual-multi as well
        keymap = {
          preset = "none",
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
        },
        completion = {
          list = {
            selection = {
              preselect = false,
              auto_insert = false,
            },
          },
          menu = {
            enabled = true,
            max_height = 12,
            border = "single",
            auto_show = false,
            draw = {
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
            auto_show_delay_ms = 100,
            window = {
              border = "single",
            },
          },
          ghost_text = {
            enabled = false,
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
          frecency = {
            enabled = true,
          },
        },
        signature = {
          enabled = true,
          trigger = {
            enabled = true,
            show_on_insert = true,
          },
          window = {
            show_documentation = false,
          },
        },
        cmdline = {
          enabled = true,
          sources = {
            "cmdline",
          },
          keymap = {
            preset = "none",
            ["<Tab>"] = { "show", "select_and_accept", "fallback" },
            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },
            ["<C-Up>"] = {
              function(cmp)
                return cmp.select_prev({ count = 3 })
              end,
            },
            ["<C-Down>"] = {
              function(cmp)
                return cmp.select_next({ count = 3 })
              end,
            },
            ["<CR>"] = { "accept", "fallback" },
            ["<Esc>"] = { "cancel", "fallback" },
            ["<C-c>"] = { "cancel", "fallback" },
          },
          completion = {
            list = {
              selection = {
                preselect = false,
                auto_insert = false,
              },
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
