return {
  {
    "akinsho/flutter-tools.nvim",
    version = "*",
    lazy = true,
    ft = "dart",
    config = function()
      require("flutter-tools").setup({
        ui = {
          border = "rounded",
          notification_style = "plugin",
        },
        decorations = {
          statusline = {
            app_version = false,
            device = true,
            project_config = false,
          },
        },
        root_patterns = { ".git", "pubspec.yaml" },
        fvm = false,
        widget_guides = {
          enabled = true,
        },
        closing_tags = {
          highlight = "Comment",
          prefix = ">> ",
          priority = 0,
          enabled = true,
        },
        dev_log = {
          enabled = true,
          filter = nil,
          notify_errors = false,
          open_cmd = "tabedit",
        },
        dev_tools = {
          autostart = false,
          auto_open_browser = false,
        },
        outline = {
          open_cmd = "30vnew",
          auto_open = false,
        },
        lsp = {
          color = {
            enabled = true,
            background = true,
            background_color = nil,
            foreground = false,
            virtual_text = false,
            virtual_text_str = "■",
          },
          settings = {
            showTodos = true,
            completeFunctionCalls = true,
            analysisExcludedFolders = nil,
            renameFilesWithClasses = "prompt",
            enableSnippets = true,
            updateImportsOnRename = true,
          },
        },
      })
    end,
  },
}
