return {
  settings = {
    Lua = {
      runtime = {
        version = "Lua 5.1",
      },
      diagnostics = {
        globals = { "vim", "Snacks" },
        unusedLocalExclude = { "_" },
      },
      workspace = {
        library = {
          vim.api.nvim_get_runtime_file("", true),
          vim.env.VIMRUNTIME,
          "${3rd}/luv/library",
          "/usr/share/hypr/stubs",
        },
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
      single_file_support = false,
    },
  },
}
