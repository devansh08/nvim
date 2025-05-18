return {
  {
    "stevearc/conform.nvim",
    lazy = true,
    event = "BufWritePre",
    opts = {
      formatters_by_ft = {
        c = { "clang_format" },
        cpp = { "clang_format" },
        fish = { "fish_indent" },
        go = { "goimports" },
        java = { "google_java_format" },
        json = { "jq" },
        kotlin = { "ktlint" },
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
        css = { "prettierd" },
        scss = { "prettierd" },
        sh = { "shfmt" },
        lua = { "stylua" },
        toml = { "taplo" },
        python = { "black" },
      },
      format_on_save = function()
        if vim.g.disable_autoformat then
          vim.g.disable_autoformat = false
          return
        elseif vim.g.force_disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_fallback = true }
      end,
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2", "-ln", "bash" },
        },
        stylua = {
          prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
        },
      },
    },
  },
}
