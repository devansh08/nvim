return {
	{
		"rcarriga/nvim-dap-ui",
		version = "*",
		lazy = true,
		config = function()
			local dap, dapui = require("dap"), require("dapui")

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			dapui.setup()
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		branch = "master",
		lazy = true,
		opts = {
			enabled = true,
			enabled_commands = true,
			highlight_changed_variables = true,
			highlight_new_as_changed = false,
			show_stop_reason = true,
			commented = false,
			only_first_definition = false,
			all_references = true,
			clear_on_continue = false,
			display_callback = function(variable)
				return variable.name .. " = " .. variable.value
			end,
			virt_text_pos = "eol",
			all_frames = false,
			virt_lines = false,
			virt_text_win_col = nil,
		},
	},
	{
		"mfussenegger/nvim-dap",
		version = "*",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"mxsdev/nvim-dap-vscode-js",
			"mfussenegger/nvim-dap-python",
		},
	},
}
