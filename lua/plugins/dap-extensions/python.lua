return {
  "mfussenegger/nvim-dap-python",
  branch = "master",
  lazy = true,
  config = function()
    local dap_python = require("dap-python")

    local constants = require("constants")

    dap_python.setup(constants.MASON_PACKAGES .. "/debugpy/venv/bin/python")

    local set_keymaps = require("utils").set_keymaps

    local opts = require("constants").OPTS

    set_keymaps("n", {
      ["<leader>dPc"] = { ":lua require('dap-python').test_class()<CR>", "DAP: Python - Test Class" },
      ["<leader>dPm"] = { ":lua require('dap-python').test_method()<CR>", "DAP: Python - Test Method" },
    }, opts, true)

    set_keymaps("v", {
      ["<leader>dPs"] = { ":lua require('dap-python').debug_selection()<CR>", "DAP: Python - Debug Selection" },
    }, opts, true)
  end,
}
