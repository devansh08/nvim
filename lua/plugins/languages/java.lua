return {
  {
    "mfussenegger/nvim-jdtls",
    branch = "master",
    lazy = true,
    ft = "java",
    config = function()
      local jdtls = require("jdtls")
      local jdtls_setup = require("jdtls.setup")

      local constants = require("constants")

      local WORKSPACE_PATH = constants.NVIM_LOCAL .. "/jdtls-workspace/"
      local PROJECT_NAME = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
      local WORKSPACE_DIR = WORKSPACE_PATH .. PROJECT_NAME
      local OS_CONFIG = "linux"

      -- lua/lsp/init.lua
      local lsp_defaults = require("lsp")

      local capabilities = lsp_defaults.capabilities
      local extended_capabilities = jdtls.extendedClientCapabilities
      extended_capabilities.resolveAdditionalTextEditsSupport = true

      local config = {
        cmd = {
          "java",
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ALL",
          "-Xms1g",
          "--add-modules=ALL-SYSTEM",
          "--add-opens",
          "java.base/java.util=ALL-UNNAMED",
          "--add-opens",
          "java.base/java.lang=ALL-UNNAMED",
          "-javaagent:" .. constants.MASON_PACKAGES .. "/jdtls/lombok.jar",
          "-jar",
          vim.fn.glob(constants.MASON_PACKAGES .. "/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
          "-configuration",
          constants.MASON_PACKAGES .. "/jdtls/config_" .. OS_CONFIG,
          "-data",
          WORKSPACE_DIR,
        },
        root_dir = jdtls_setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
        capabilities = capabilities,
        settings = {
          java = {
            eclipse = {
              downloadSources = true,
            },
            configuration = {
              updateBuildConfiguration = "interactive",
            },
            maven = {
              downloadSources = true,
            },
            implementationsCodeLens = {
              enabled = true,
            },
            referencesCodeLens = {
              enabled = true,
            },
            references = {
              includeDecompiledSources = true,
            },
            inlayHints = {
              parameterNames = {
                enabled = "all",
              },
            },
            format = {
              enabled = true,
            },
          },
          signatureHelp = { enabled = true },
          extendedClientCapabilities = extended_capabilities,
        },
        on_attach = function(client)
          vim.lsp.codelens.refresh()
          lsp_defaults.on_attach(client)
        end,
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
          jdtls.start_or_attach(config)
        end,
        group = vim.api.nvim_create_augroup("AttachJDTLS", { clear = true }),
      })
    end,
  },
}
