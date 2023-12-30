return {
	{
		"nvim-telescope/telescope-dap.nvim",
		branch = "master",
		lazy = true,
	},
	{
		"nvim-telescope/telescope.nvim",
		branch = "master",
		dependencies = {
			"nvim-telescope/telescope-dap.nvim",
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local actions_set = require("telescope.actions.set")

			local custom_keymaps = {
				i = {
					["<CR>"] = actions.select_tab_drop,
					["<C-T>"] = actions.select_default,
				},
				n = {
					["<CR>"] = actions.select_tab_drop,
					["<C-T>"] = actions.select_default,
				},
			}

			telescope.setup({
				defaults = {
					layout_strategy = "horizontal",
					layout_config = {
						scroll_speed = 1,
						horizontal = {
							height = 0.8,
							width = 0.9,
							preview_width = 0.5,
						},
					},
					path_display = {
						shorten = {
							len = 1,
							exclude = { -1, -2, -3 },
						},
					},
					dynamic_preview_title = true,
					mappings = {
						n = {
							["<C-Up>"] = function(bufnr)
								actions_set.shift_selection(bufnr, -3)
							end,
							["<C-Down>"] = function(bufnr)
								actions_set.shift_selection(bufnr, 3)
							end,
							["<C-S-Up>"] = actions.preview_scrolling_up,
							["<C-S-Down>"] = actions.preview_scrolling_down,
							["<C-Left>"] = actions.preview_scrolling_left,
							["<C-Right>"] = actions.preview_scrolling_right,

							["<C-c>"] = actions.close,
						},
						i = {
							["<C-Up>"] = function(bufnr)
								actions_set.shift_selection(bufnr, -3)
							end,
							["<C-Down>"] = function(bufnr)
								actions_set.shift_selection(bufnr, 3)
							end,
							["<C-S-Up>"] = actions.preview_scrolling_up,
							["<C-S-Down>"] = actions.preview_scrolling_down,
							["<C-Left>"] = actions.preview_scrolling_left,
							["<C-Right>"] = actions.preview_scrolling_right,

							["<C-c>"] = actions.close,
						},
					},
				},
				pickers = {
					find_files = {
						find_command = {
							"rg",
							"--files",
							"--color=never",
							"--follow",
							"--hidden",
							"--ignore",
							"--smart-case",
							"--sort=modified",
							"--glob=!**/.git/*",
						},
						hidden = true,
						mappings = custom_keymaps,
					},
					live_grep = {
						mappings = custom_keymaps,
					},
					jumplist = {
						show_line = false,
					},
					buffers = {
						sort_mru = true,
					},
					git_commits = {
						git_command = {
							"git",
							"log",
							"--format=%h %s %d",
						},
					},
					git_bcommits = {
						git_command = {
							"git",
							"log",
							"--format=%h %s %d",
						},
					},
					git_bcommits_range = {
						git_command = {
							"git",
							"log",
							"--format=%h %s %d",
							"--no-patch",
							"-L",
						},
					},
					lsp_references = {
						jump_type = "never",
						show_line = false,
						mappings = custom_keymaps,
					},
					lsp_implementations = {
						jump_type = "never",
						reuse_win = true,
						show_line = false,
						mappings = custom_keymaps,
					},
					lsp_definitions = {
						jump_type = "never",
						reuse_win = true,
						show_line = false,
						mappings = custom_keymaps,
					},
					diagnostics = {
						mappings = custom_keymaps,
					},
				},
				extensions = {
					["session-lens"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			telescope.load_extension("refactoring")
			telescope.load_extension("dap")
			telescope.load_extension("session-lens")
		end,
	},
}
