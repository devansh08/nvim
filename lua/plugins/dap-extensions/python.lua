return {
	"mfussenegger/nvim-dap-python",
	branch = "master",
	lazy = true,
	ft = { "python" },
	config = function()
		local dap_python = require("dap-python")

		local constants = require("constants")

		dap_python.setup(constants.MASON_PACKAGES .. "/debugpy/venv/bin/python")

		local utils = require("utils")
		local set_keymaps = utils.set_keymaps

		set_keymaps("n", {
			["<leader>dPc"] = { ":lua require('dap-python').test_class()<CR>", "DAP: Python - Test Class" },
			["<leader>dPm"] = { ":lua require('dap-python').test_method()<CR>", "DAP: Python - Test Method" },
		}, { noremap = true, silent = true }, true)

		set_keymaps("n", {
			["<leader>dPs"] = { ":lua require('dap-python').debug_selection()<CR>", "DAP: Python - Debug Selection" },
		}, { noremap = true, silent = true }, true)
	end,
}
