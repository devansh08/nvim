return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = "*",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSUpdateSync" },
		build = ":TSUpdate",
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-context",
				branch = "master",
				lazy = true,
				config = function()
					local opts = {
						enable = true,
						line_numbers = true,
					}

					require("treesitter-context").setup(opts)
				end,
			},
			{
				"hiphish/rainbow-delimiters.nvim",
				branch = "master",
				lazy = true,
				config = function()
					local rainbow_delimiters = require("rainbow-delimiters")

					vim.g.rainbow_delimiters = {
						strategy = {
							[""] = rainbow_delimiters.strategy["global"],
							vim = rainbow_delimiters.strategy["local"],
						},
						query = {
							[""] = "rainbow-delimiters",
							lua = "rainbow-blocks",
							javascript = "rainbow-delimiters-ract",
						},
						highlight = {
							"RainbowDelimiterRed",
							"RainbowDelimiterYellow",
							"RainbowDelimiterBlue",
							"RainbowDelimiterOrange",
							"RainbowDelimiterGreen",
							"RainbowDelimiterViolet",
							"RainbowDelimiterCyan",
						},
					}
				end,
			},
			{
				"lukas-reineke/indent-blankline.nvim",
				version = "*",
				lazy = true,
				main = "ibl",
				config = function()
					local highlight = {
						"RainbowDelimiterRed",
						"RainbowDelimiterYellow",
						"RainbowDelimiterBlue",
						"RainbowDelimiterOrange",
						"RainbowDelimiterGreen",
						"RainbowDelimiterViolet",
						"RainbowDelimiterCyan",
					}
					local hooks = require("ibl.hooks")

					vim.g.rainbow_delimiters = { highlight = highlight }
					require("ibl").setup({
						indent = {
							char = "╎",
						},
						scope = {
							enabled = true,
							char = "╎",
							show_start = true,
							show_end = true,
							show_exact_scope = true,
							highlight = highlight,
						},
					})

					hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
				end,
			},
			{
				"windwp/nvim-ts-autotag",
				branch = "main",
				lazy = true,
				config = function()
					local opts = {
						autotag = {
							enable = true,
							enable_rename = true,
							enable_close = true,
							enable_close_on_slash = true,
						},
					}

					require("nvim-treesitter.configs").setup(opts)
				end,
			},
		},
		config = function()
			local opts = {
				ensure_installed = {
					"bash",
					"c",
					"css",
					"dockerfile",
					"fish",
					"html",
					"java",
					"javascript",
					"json",
					"json5",
					"jsonc",
					"kotlin",
					"lua",
					"markdown",
					"python",
					"scss",
					"sql",
					"toml",
					"tsx",
					"typescript",
					"vim",
					"yaml",
				},
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
				autopairs = {
					enable = true,
				},
				context_commentstring = {
					enable = true,
				},
			}

			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		branch = "main",
		lazy = true,
	},
}
