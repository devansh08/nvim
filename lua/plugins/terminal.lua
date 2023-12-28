return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		local opts = {
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return 80
				end
			end,
			open_mapping = "<C-E>",
			hide_numbers = true,
			direction = "float",
			float_opts = {
				border = "rounded",
				width = 180,
				height = 36,
			},
			close_on_exit = true,
			auto_scroll = true,
			--      persist_mode = false,
			start_in_insert = true,
		}

		require("toggleterm").setup(opts)
	end,
}
