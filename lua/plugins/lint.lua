return {
  {
    "mfussenegger/nvim-lint",
    branch = "master",
    lazy = true,
    event = "BufWritePre",
    config = function()
      local lint = require("lint")

      table.insert(lint.linters.revive.args, "-config")
      table.insert(lint.linters.revive.args, "/home/devansh/.config/.revive.toml")

      lint.linters_by_ft = {
        bash = { "bash" },
        c = { "cpplint" },
        cpp = { "cpplint" },
        go = { "revive" },
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        kotlin = { "ktlint" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        python = { "ruff" },
        sh = { "bash" },
      }
    end,
  },
}
