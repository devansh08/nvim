return {
  settings = {
    Lua = {
      runtime = {
        version = "Lua 5.1",
      },
      diagnostics = {
        globals = { "vim" },
        unusedLocalExclude = { "_" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
      single_file_support = false,
    },
  },
}
