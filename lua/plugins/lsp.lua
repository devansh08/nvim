return {
  {
    "williamboman/mason.nvim",
    tag = "stable",
    lazy = true,
    cmd = "Mason",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({
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
      })

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
        ["fish-lsp"] = { { "fish" } },
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
        capabilities = vim.tbl_deep_extend(
          "force",
          vim.lsp.protocol.make_client_capabilities(),
          require("blink.cmp").get_lsp_capabilities({}, false)
        ),
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
    branch = "main",
    lazy = true,
    event = "VeryLazy",
    -- Reference: https://github.com/j-hui/fidget.nvim?tab=readme-ov-file#options
    opts = {
      progress = {
        suppress_on_insert = true,
      },
      notification = {
        window = {
          border = "single",
          avoid = { "NvimTree" },
        },
      },
    },
  },
}
