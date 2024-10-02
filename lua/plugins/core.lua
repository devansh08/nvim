return {
	{
		"folke/lazy.nvim",
		tag = "stable",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"rmagatti/auto-session",
		branch = "main",
		priority = 1001,
		dependencies = {
			"nvim-tree/nvim-tree.lua",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local constants = require("constants")

			local function close_nvim_tree()
				local nvim_tree_api = require("nvim-tree.api")
				nvim_tree_api.tree.close()
			end

			local function open_nvim_tree()
				local nvim_tree_api = require("nvim-tree.api")
				nvim_tree_api.tree.open()
			end

			require("auto-session").setup({
				enabled = true,
				root_dir = constants.NVIM_LOCAL .. "/sessions/",
				auto_save = true,
				auto_restore = true,
				auto_create = true,
				allowed_dirs = nil,
				auto_restore_last_session = false,
				use_git_branch = true,
				lazy_support = true,
				bypass_save_filetypes = nil,
				close_unsupported_windows = true,
				args_allow_single_directory = true,
				args_allow_files_auto_save = false,
				continue_restore_on_error = true,
				cwd_change_handling = false,
				log_level = "error",
				pre_save_cmds = { close_nvim_tree },
				post_restore_cmds = { open_nvim_tree },
				session_lens = {
					load_on_setup = false,
				},
			})

			vim.o.sessionoptions = "buffers,curdir,tabpages,winsize,winpos,localoptions"
		end,
	},
}
