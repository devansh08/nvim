return {
  {
    "rebelot/heirline.nvim",
    version = "*",
    config = function()
      vim.opt.showtabline = 2

      local COLORS = require("catppuccin.palettes.mocha")
      local ICONS = require("nvim-web-devicons")

      local conditions = require("heirline.conditions")
      local utils = require("heirline.utils")

      local redrawCallback = vim.schedule_wrap(function()
        vim.cmd("redrawstatus")
      end)

      local ignoreFileTypes = { "lazy", "mason", "NvimTree", "Trouble", "Telescope.*", "toggleterm" }

      local Align = {
        provider = "%=",
      }

      local ViMode = {
        init = function(self)
          self.mode = vim.fn.mode(1)
          self.modeObj = self.modes[self.mode]
        end,
        condition = conditions.is_active,
        static = {
          modes = {
            n = { str = "NORMAL", fgColor = "base", bgColor = "blue" },
            no = { str = "O-PNDG", fgColor = "base", bgColor = "blue" },
            v = { str = "VISUAL", fgColor = "base", bgColor = "yellow" },
            V = { str = "V-LINE", fgColor = "base", bgColor = "yellow" },
            ["\22"] = { str = "V-BLCK", fgColor = "base", bgColor = "yellow" },
            i = { str = "INSERT", fgColor = "base", bgColor = "green" },
            c = { str = "C-LINE", fgColor = "base", bgColor = "red" },
            t = { str = "TERMNL", fgColor = "base", bgColor = "sky" },
            nt = { str = "TERMNL", fgColor = "base", bgColor = "sky" },
          },
        },
        provider = function(self)
          if self.modeObj ~= nil then
            return " " .. self.modeObj.str .. " "
          else
            return "UNKNOWN: " .. self.mode
          end
        end,
        hl = function(self)
          if self.modeObj ~= nil then
            return {
              fg = self.modeObj.fgColor,
              bg = self.modeObj.bgColor,
              bold = true,
            }
          else
            return {
              fg = "base",
              bg = "red",
              bold = true,
            }
          end
        end,
        update = {
          "ModeChanged",
          pattern = "*:*",
          callback = redrawCallback,
        },
      }

      local Git = {
        condition = function()
          return conditions.is_git_repo() and conditions.is_active()
        end,
        init = function(self)
          self.status = vim.b.gitsigns_status_dict
          self.hasChanges = self.status.added ~= 0 or self.status.removed ~= 0 or self.status.changed ~= 0
        end,
        hl = {
          bg = "surface0",
        },
        {
          provider = function(self)
            return "  " .. self.status.head .. " "
          end,
          hl = {
            fg = "blue",
          },
        },
        {
          condition = function(self)
            return self.hasChanges and (self.status.added or 0) > 0
          end,
          provider = function(self)
            return "+" .. self.status.added .. " "
          end,
          hl = {
            fg = "green",
          },
        },
        {
          condition = function(self)
            return self.hasChanges and (self.status.changed or 0) > 0
          end,
          provider = function(self)
            return "~" .. self.status.changed .. " "
          end,
          hl = {
            fg = "yellow",
          },
        },
        {
          condition = function(self)
            return self.hasChanges and (self.status.removed or 0) > 0
          end,
          provider = function(self)
            return "-" .. self.status.removed .. " "
          end,
          hl = {
            fg = "red",
          },
        },
        update = {
          "BufWritePost",
          "BufEnter",
          pattern = "*",
          callback = redrawCallback,
        },
      }

      local Diagnostics = {
        condition = function(self)
          self.counts = vim.diagnostic.count(0)
          return ((self.counts[self.severity.ERROR] or 0) > 0 or (self.counts[self.severity.WARN] or 0) > 0)
            and conditions.is_active()
        end,
        static = {
          severity = {
            ERROR = 1,
            WARN = 2,
          },
          icons = {
            ERROR = "",
            WARN = "",
          },
        },
        {
          provider = " ",
        },
        {
          condition = function(self)
            return (self.counts[self.severity.ERROR] or 0) > 0
          end,
          provider = function(self)
            return self.icons.ERROR .. " " .. self.counts[self.severity.ERROR] .. " "
          end,
          hl = {
            fg = "red",
          },
        },
        {
          condition = function(self)
            return (self.counts[self.severity.WARN] or 0) > 0
          end,
          provider = function(self)
            return self.icons.WARN .. " " .. self.counts[self.severity.WARN] .. " "
          end,
          hl = {
            fg = "yellow",
          },
        },
        hl = {
          bg = "base",
        },
        update = {
          "BufWritePost",
          "BufEnter",
          pattern = "*",
          callback = redrawCallback,
        },
      }

      local FileFlags = {
        {
          condition = function(self)
            if self.tabpage then
              return vim.api.nvim_get_option_value(
                "modified",
                { buf = vim.api.nvim_win_get_buf(vim.api.nvim_tabpage_get_win(self.tabpage)) }
              )
            else
              return vim.bo.modified
            end
          end,
          provider = function(self)
            return self.is_active ~= nil and " ●" or "● "
          end,
          hl = function(self)
            local fg = "green"
            local bg = "mantle"
            if self.is_active ~= nil then
              if self.is_active == true then
                fg = "base"
                bg = "blue"
              else
                fg = "blue"
                bg = "base"
              end
            end
            return {
              fg = fg,
              bg = bg,
            }
          end,
        },
        {
          condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
          end,
          provider = function(self)
            return self.is_active == nil and " "
          end,
          hl = {
            fg = "yellow",
          },
        },
      }

      local FileName = {
        init = function(self)
          self.fname = vim.fn.expand("%:t")
          if self.fname == "" then
            self.fname = "[No Name]"
          end
        end,
        provider = function(self)
          return " " .. self.fname .. " "
        end,
        hl = function()
          local fg = "text"
          if conditions.is_not_active() then
            fg = "surface2"
          end

          return {
            fg = fg,
            bg = "mantle",
          }
        end,
        FileFlags,
      }

      ---Return icon and iconColor for given filetype
      ---@param ft string
      ---@return string, any
      function GetIcon(ft)
        return ICONS.get_icon_color_by_filetype(ft)
      end

      local FileIcon = {
        init = function(self)
          self.icon, self.iconColor = GetIcon(vim.bo.filetype)
        end,
        condition = conditions.is_active,
        provider = function(self)
          return self.icon and (" " .. self.icon)
        end,
        hl = function(self)
          return {
            fg = self.iconColor,
          }
        end,
      }

      local FileType = {
        condition = conditions.is_active,
        FileIcon,
        {
          provider = function()
            return " " .. vim.bo.filetype .. " "
          end,
          hl = {
            fg = "text",
          },
        },
        hl = {
          bg = "surface0",
        },
      }

      local Ruler = {
        provider = " %P %l:%c ",
        condition = conditions.is_active,
        hl = {
          fg = "base",
          bg = "blue",
          bold = true,
        },
      }

      local Lsp = {
        condition = function()
          return conditions.lsp_attached() and conditions.is_active()
        end,
        init = function(self)
          self.servers = vim.lsp.get_clients({ bufnr = 0 })
        end,
        provider = function(self)
          local names = {}
          for _, v in pairs(self.servers) do
            table.insert(names, v.name)
          end

          return "󰒋 " .. table.concat(names, "|") .. " "
        end,
        hl = {
          fg = "text",
          bg = "mantle",
        },
      }

      local Macro = {
        condition = function()
          return vim.fn.reg_recording() ~= ""
        end,
        provider = function()
          return "  " .. vim.fn.reg_recording() .. " "
        end,
        hl = {
          fg = "red",
          bg = "mantle",
        },
        update = {
          "RecordingEnter",
          "RecordingLeave",
          pattern = "*",
          callback = redrawCallback,
        },
      }

      local SearchCount = {
        condition = function()
          return conditions.is_active() and vim.v.hlsearch ~= 0
        end,
        init = function(self)
          local search = vim.fn.searchcount()
          if search ~= nil and search.total then
            self.search = search
          end
        end,
        provider = function(self)
          local search = self.search
          return string.format(" [%d/%d] ", search.current, search.total)
        end,
        hl = {
          fg = "base",
          bg = "blue",
          bold = true,
        },
      }

      local SelectCount = {
        condition = function()
          return vim.fn.mode():find("[Vv]") ~= nil
        end,
        provider = function()
          local starts = vim.fn.line("v")
          local ends = vim.fn.line(".")
          local lines = starts <= ends and ends - starts + 1 or starts - ends + 1
          local count = vim.fn.wordcount()
          return " "
            .. tostring(lines)
            .. "L/"
            .. tostring(count.visual_chars)
            .. "W/"
            .. tostring(count.visual_chars)
            .. "C "
        end,
        hl = {
          fg = "base",
          bg = "blue",
          bold = true,
        },
      }

      local Tabpage = {
        FileFlags,
        {
          init = function(self)
            ---@type table<string, table<string|integer>>
            local tabNames = {}
            for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
              local name = vim.api
                .nvim_buf_get_name(vim.api.nvim_win_get_buf(vim.api.nvim_tabpage_get_win(tabpage)))
                :gsub(vim.loop.cwd() .. "/", "")

              if name == "" then
                name = "[No Name]"
              end
              tabNames[tabpage] = name
            end
            self.tabNames = tabNames
          end,
          provider = function(self)
            return " " .. self.tabNames[self.tabpage] .. " "
          end,
          hl = function(self)
            if self.is_active then
              return {
                fg = "crust",
                bg = "blue",
                bold = true,
              }
            else
              return {
                fg = "blue",
              }
            end
          end,
          update = { "BufEnter" },
        },
      }

      local StatusLineLeft = {
        ViMode,
        Git,
        Diagnostics,
        FileName,
        Macro,
      }
      local StatusLineRight = {
        Lsp,
        FileType,
        Ruler,
        SearchCount,
        SelectCount,
      }

      local TabLineLeft = {
        utils.make_tablist(Tabpage),
      }

      require("heirline").setup({
        statusline = {
          condition = function()
            return not conditions.buffer_matches({
              filetype = ignoreFileTypes,
            })
          end,
          StatusLineLeft,
          Align,
          StatusLineRight,
        },
        tabline = {
          TabLineLeft,
        },
        opts = {
          colors = {
            base = COLORS.base,
            crust = COLORS.crust,
            mantle = COLORS.mantle,
            surface0 = COLORS.surface0,
            surface1 = COLORS.surface1,
            surface2 = COLORS.surface2,
            overlay0 = COLORS.overlay0,
            overlay1 = COLORS.overlay1,
            overlay2 = COLORS.overlay2,
            text = COLORS.text,
            subtext1 = COLORS.subtext1,
            subtext0 = COLORS.subtext0,
            red = COLORS.red,
            green = COLORS.green,
            blue = COLORS.blue,
            yellow = COLORS.yellow,
            sky = COLORS.sky,
          },
        },
      })
    end,
  },
}
