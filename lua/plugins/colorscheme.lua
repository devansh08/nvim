return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		tag = "stable",
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
				integrations = {
					nvimtree = true,
					gitsigns = true,
					telescope = true,
					mason = true,
					treesitter = true,
					treesitter_context = true,
					rainbow_delimiters = true,
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = { "italic" },
							hints = { "italic" },
							warnings = { "italic" },
							information = { "italic" },
						},
						underlines = {
							errors = { "underline" },
							hints = { "underline" },
							warnings = { "underline" },
							information = { "underline" },
						},
						inlay_hints = {
							background = true,
						},
					},
				},
			})

			vim.cmd([[ colorscheme catppuccin ]])
		end,
	},
}
