return {
	"mxsdev/nvim-dap-vscode-js",
	branch = "main",
	lazy = true,
	ft = { "javascript", "typescript" },
	config = function()
		local dap = require("dap")

		local constants = require("constants")

		require("dap-vscode-js").setup({
			node_path = "node",
			log_file_path = constants.NVIM_CACHE .. "/dap-vscode-js.log",
			log_file_level = vim.log.levels.WARN,
			log_console_level = vim.log.levels.ERROR,
			debugger_path = constants.MASON_PACKAGES .. "/js-debug-adapter/js-debug-adapter",
			debugger_cmd = { constants.MASON_PACKAGES .. "/js-debug-adapter/js-debug-adapter" },
			adapters = { "pwa-node", "node-terminal" },
		})

		for _, language in ipairs({ "typescript", "javascript" }) do
			dap.configurations[language] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch File",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach Debugger",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
			}
		end
	end,
}
