return {
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    branch = "main",
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
  },
  {
    "axelvc/template-string.nvim",
    branch = "main",
    lazy = true,
    ft = { "html", "typescript", "javascript", "typescriptreact", "javascriptreact", "python" },
    -- Reference: https://github.com/axelvc/template-string.nvim?tab=readme-ov-file#configuration
    opts = {
      filetypes = {
        "html",
        "typescript",
        "javascript",
        "typescriptreact",
        "javascriptreact",
        "python",
      },
      remove_template_string = true,
      restore_quotes = {
        normal = [["]],
        jsx = [["]],
      },
    },
  },
}
