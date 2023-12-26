return {
	{
		"folke/lazy.nvim",
		tag = "stable",
	},
	{
		"rmagatti/auto-session",
		branch = "main",
		config = function()
			local constants = require("constants")

			require("auto-session").setup({
				log_level = "error",
				auto_session_enable_last_session = false,
				auto_session_root_dir = constants.NVIM_LOCAL .. "/sessions/",
				auto_session_enabled = true,
				auto_session_create_enabled = true,
				session_lens = {
					buftypes_to_ignore = {},
					load_on_setup = true,
					theme_conf = { border = true, winblend = 0 },
					previewer = false,
				},
			})

			vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
		end,
	},
}
