return {
  "leoluz/nvim-dap-go",
  branch = "main",
  lazy = true,
  config = function()
    local dap_go = require("dap-go")

    dap_go.setup()

    local set_keymaps = require("utils").set_keymaps

    local opts = require("constants").OPTS

    set_keymaps("n", {
      ["<leader>dGc"] = { ":lua require('dap-go').debug_test()", "DAP: Go - Debug Current Test" },
      ["<leader>dGl"] = { ":lua require('dap-go').debug_last_test()", "DAP: Go - Debug Last Test" },
    }, opts, true)
  end,
}
