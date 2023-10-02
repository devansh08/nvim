return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		pritority = 1000,
		config = function()
			local flavour = "macchiato"

      require("catppuccin").setup({
				flavour = flavour,
				background = {
					dark = flavour,
				},
				term_colors = true,
				no_italic = false,
				no_bold = true,
				styles = {
					comments = { "italic" },
					conditionals = {},
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
				},
			})

			vim.cmd([[ colorscheme catppuccin ]])
		end,
	},
}

