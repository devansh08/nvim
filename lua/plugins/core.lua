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
				log_level = "error",
				auto_session_enable_last_session = false,
				auto_session_root_dir = constants.NVIM_LOCAL .. "/sessions/",
				auto_session_enabled = true,
				auto_session_create_enabled = true,
				auto_session_last_session_dir = "",
				pre_save_cmds = { close_nvim_tree },
				post_restore_cmds = { open_nvim_tree },
				session_lens = {
					buftypes_to_ignore = {},
					load_on_setup = true,
					theme_conf = { border = true, winblend = 0 },
					previewer = false,
				},
			})

			vim.o.sessionoptions = "buffers,curdir,tabpages,winsize,winpos,localoptions"
		end,
	},
}
