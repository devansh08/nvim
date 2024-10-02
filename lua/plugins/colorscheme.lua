return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		tag = "stable",
		pritority = 1000,
		config = function()
			local flavour = "mocha"

			require("catppuccin").setup({
				flavour = flavour,
				background = {
					dark = flavour,
				},
				term_colors = true,
				no_italic = false,
				no_bold = false,
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
					indent_blankline = {
						enabled = true,
						scope_color = "",
						colored_indent_levels = false,
					},
					navic = {
						enabled = true,
					},
					ufo = true,
					fidget = true,
				},
				highlight_overrides = {
					[flavour] = function(f)
						local darken = require("catppuccin.utils.colors").darken

						return {
							LspReferenceRead = { bg = f.surface2 },
							LspReferenceWrite = { bg = f.surface2 },
							LspReferenceText = { bg = f.surface2 },

							DiffAdd = { bg = darken(f.green, 0.25, f.base) },
							DiffChange = { bg = darken(f.blue, 0.15, f.base) },
							DiffDelete = { bg = darken(f.red, 0.25, f.base) },
							DiffText = { bg = darken(f.blue, 0.30, f.base) },
						}
					end,
				},
			})

			vim.cmd([[ colorscheme catppuccin ]])
		end,
	},
}
