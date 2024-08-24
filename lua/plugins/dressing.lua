return {
	{
		"stevearc/dressing.nvim",
		tag = "stable",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("dressing").setup({
				input = {
					enabled = true,
					default_prompt = "Input:",
					title_pos = "left",
					insert_only = true,
					start_in_insert = true,
					border = "rounded",
					relative = "cursor",
					prefer_width = 40,
					width = 40,
					max_width = { 140 },
					min_width = { 40 },
					buf_options = {},
					win_options = {
						wrap = false,
						list = true,
						listchars = "precedes:…,extends:…",
						sidescrolloff = 0,
					},
					mappings = {
						n = {
							["<Esc>"] = "Close",
							["<CR>"] = "Confirm",
						},
						i = {
							["<C-c>"] = "Close",
							["<CR>"] = "Confirm",
							["<Up>"] = "HistoryPrev",
							["<Down>"] = "HistoryNext",
						},
					},
					get_config = nil,
				},
				select = {
					enabled = true,
					backend = { "telescope", "builtin" },
					trim_prompt = true,
					telescope = require("telescope.themes").get_dropdown(),
					builtin = {
						show_numbers = true,
						border = "rounded",
						relative = "editor",
						buf_options = {},
						win_options = {
							cursorline = true,
							cursorlineopt = "both",
						},
						width = nil,
						max_width = { 140, 0.8 },
						min_width = { 40, 0.2 },
						height = nil,
						max_height = 0.9,
						min_height = { 10, 0.2 },
						mappings = {
							["<Esc>"] = "Close",
							["<C-c>"] = "Close",
							["<CR>"] = "Confirm",
						},
					},
					get_config = function(opts)
						local string_starts_with = require("utils").string_starts_with
						local kind = opts.kind

						if kind ~= nil and string_starts_with(kind, "nvimtree") then
							return {
								backend = { "telescope" },
								telescope = require("telescope.themes").get_cursor({
									layout_config = {
										width = 0.2,
									},
								}),
							}
						else
							return {
								backend = { "telescope" },
								telescope = require("telescope.themes").get_dropdown(),
							}
						end
					end,
					format_item_override = {},
				},
			})
		end,
	},
}
