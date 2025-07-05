return {
  {
    "williamboman/mason.nvim",
    tag = "stable",
    lazy = true,
    cmd = "Mason",
    build = ":MasonUpdate",
    config = function()
      local opts = {
        pip = {
          install_args = { "--timeout", "999" },
        },
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
          border = "single",
          width = 0.8,
          height = 0.8,
        },
        log_level = vim.log.levels.TRACE,
      }

      require("mason").setup(opts)

      local utils = require("utils")
      local check_executable = utils.check_executable

      -- Long names
      local ensure_installed = check_executable({
        ["angular-language-server"] = { { "node", "npm" }, { "bun" } },
        ["bash-language-server"] = { { "bash" } },
        ["black"] = { { "python", "pip" } },
        ["clang-format"] = { { "gcc" }, { "g++" } },
        ["clangd"] = { { "gcc" }, { "g++" } },
        ["cpplint"] = { { "g++" } },
        ["css-lsp"] = {},
        ["debugpy"] = { { "python", "pip" } },
        ["dockerfile-language-server"] = { { "docker" }, { "pulumi" } },
        ["eslint_d"] = { { "node", "npm" }, { "bun" } },
        ["google-java-format"] = { { "java" } },
        ["gopls"] = { { "go" } },
        ["html-lsp"] = {},
        ["jdtls"] = { { "java" } },
        ["jedi-language-server"] = { { "python", "pip" } },
        ["js-debug-adapter"] = { { "node", "npm" }, { "bun" } },
        ["json-lsp"] = {},
        ["kotlin-language-server"] = { { "kotlin", "kotlinc" } },
        ["ktlint"] = { { "kotlin", "kotlinc" } },
        ["lua-language-server"] = { { "lua" } },
        ["marksman"] = {},
        ["prettierd"] = { { "node", "npm" }, { "bun" } },
        ["pyright"] = { { "python", "pip" } },
        ["revive"] = { { "go" } },
        ["ruff"] = { { "python", "pip" } },
        ["shfmt"] = { { "bash" } },
        ["stylua"] = { { "lua" } },
        ["taplo"] = {},
        ["typescript-language-server"] = { { "node", "npm" }, { "bun" } },
        ["yaml-language-server"] = {},
      })

      local Package = require("mason-core.package")
      local registry = require("mason-registry")

      registry.refresh()
      for _, v in ipairs(ensure_installed) do
        if not registry.is_installed(v) then
          local package_name, version = Package.Parse(v)
          local pkg = registry.get_package(package_name)

          print("[Mason] Installing package " .. v)
          pkg:install({
            version = version,
          })
        end
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    branch = "master",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "j-hui/fidget.nvim",
    },
    config = function()
      local constants = require("constants")
      if not string.find(vim.env.PATH, constants.MASON_BIN, 1, true) then
        vim.env.PATH = constants.MASON_BIN .. ":" .. vim.env.PATH
      end

      local ERROR = vim.diagnostic.severity.ERROR
      local WARN = vim.diagnostic.severity.WARN
      local INFO = vim.diagnostic.severity.INFO
      local HINT = vim.diagnostic.severity.HINT

      vim.diagnostic.config({
        signs = {
          text = {
            [ERROR] = "",
            [WARN] = "",
            [INFO] = "",
            [HINT] = "",
          },
          linehl = {},
        },
        jump = {
          severity = {
            min = WARN,
          },
          wrap = true,
        },
        underline = true,
        severity_sort = true,
        float = {
          border = "single",
          scope = "line",
          source = true,
        },
        virtual_text = false,
        virtual_lines = {
          current_line = true,
          severity = ERROR,
        },
      })

      vim.lsp.config("*", { capabilities = vim.lsp.protocol.make_client_capabilities() })

      local lsp_servers = {
        "bashls",
        "cssls",
        "dockerls",
        "gopls",
        "html",
        "lua_ls",
        "marksman",
        "taplo",
        "ts_ls",
      }

      vim.lsp.config("*", {
        capabilities = vim.lsp.protocol.make_client_capabilities(),
      })

      local lsp_settings_dir = constants.NVIM_CONFIG .. "/lua/lsp/settings/"
      local lsp_settings_files = vim.fn.readdir(lsp_settings_dir)
      for _, file in ipairs(lsp_settings_files) do
        local ok, settings = pcall(require, "lsp.settings." .. file:gsub("%.lua$", ""))
        if ok then
          local server_name = file:gsub("%.lua$", "")
          vim.lsp.config[server_name] = settings
        else
          print("[LspConfig] Error loading settings for " .. file .. ": " .. vim.inspect(settings))
        end
      end

      for _, server in ipairs(lsp_servers) do
        vim.lsp.enable(server)
      end
    end,
  },
  {
    "j-hui/fidget.nvim",
    version = "*",
    lazy = true,
    event = "VeryLazy",
    config = function()
      local opts = {
        progress = {
          poll_rate = 0,
          suppress_on_insert = true,
          ignore_done_already = false,
          ignore_empty_message = false,

          clear_on_detach = function(client_id)
            local client = vim.lsp.get_client_by_id(client_id)
            return client and client.name or nil
          end,

          notification_group = function(msg)
            return msg.lsp_client.name
          end,
          ignore = {},

          display = {
            render_limit = 16,
            done_ttl = 3,
            done_icon = "✔",
            done_style = "Constant",
            progress_ttl = math.huge,

            progress_icon = { pattern = "dots", period = 1 },

            progress_style = "WarningMsg",
            group_style = "Title",
            icon_style = "Question",
            priority = 30,
            skip_history = true,

            format_message = require("fidget.progress.display").default_format_message,

            format_annote = function(msg)
              return msg.title
            end,

            format_group_name = function(group)
              return tostring(group)
            end,
          },

          lsp = {
            progress_ringbuf_size = 0,
            log_handler = false,
          },
        },

        notification = {
          poll_rate = 10,
          filter = vim.log.levels.INFO,
          history_size = 128,
          override_vim_notify = false,

          configs = { default = require("fidget.notification").default_config },

          redirect = function(msg, level, opts)
            if opts and opts.on_open then
              return require("fidget.integration.nvim-notify").delegate(msg, level, opts)
            end
          end,

          view = {
            stack_upwards = true,
            icon_separator = " ",
            group_separator = "---",

            group_separator_hl = "Comment",

            render_message = function(msg, cnt)
              return cnt == 1 and msg or string.format("(%dx) %s", cnt, msg)
            end,
          },

          window = {
            normal_hl = "Comment",
            winblend = 0,
            border = "single",
            zindex = 45,
            max_width = 0,
            max_height = 0,
            x_padding = 1,
            y_padding = 0,
            align = "bottom",
            relative = "editor",
          },
        },

        integration = {
          ["nvim-tree"] = {
            enable = true,
          },
        },

        logger = {
          level = vim.log.levels.WARN,
          max_size = 10000,
          float_precision = 0.01,

          path = string.format("%s/fidget.nvim.log", vim.fn.stdpath("cache")),
        },
      }
      require("fidget").setup(opts)
    end,
  },
}
