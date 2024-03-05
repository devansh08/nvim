return {
	{
		"nvim-lualine/lualine.nvim",
		branch = "master",
		opts = {
			options = {
				icons_enabled = true,
				theme = "catppuccin",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					"branch",
					"diff",
					{
						"diagnostics",
						update_in_insert = true,
					},
				},
				lualine_c = { "filename" },
				lualine_x = {
					"filetype",
					function()
						local status, lint = pcall(require, "lint")
						if not status then
							return ""
						end

						local linters = lint._resolve_linter_by_ft(vim.bo.filetype)
						if #linters == 0 then
							return ""
						else
							return table.concat(linters, "|")
						end
					end,
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {
				lualine_a = {
					{
						"tabs",
						max_length = vim.o.columns,
						mode = 1,
						path = 1,
						show_modified_status = true,
						symbols = {
							modified = "",
						},
					},
				},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			winbar = {
				lualine_a = {},
				lualine_b = {
					{
						"filename",
						file_status = false,
						path = 1,
						shorting_target = 40,
						symbols = {},
					},
				},
				lualine_c = { "navic" },
				lualine_x = {},
				lualine_y = { "selectioncount" },
				lualine_z = { "searchcount" },
			},
			inactive_winbar = {
				lualine_a = {},
				lualine_b = {
					{
						"filename",
						file_status = false,
						path = 1,
						shorting_target = 40,
						symbols = {},
					},
				},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			extensions = {
				"lazy",
				"nvim-tree",
				"toggleterm",
			},
		},
	},
	{
		"SmiteshP/nvim-navic",
		branch = "master",
		lazy = true,
		opts = {
			highlight = true,
			depth_limit = 0,
			depth_limit_indicator = "…",
			lazy_update_context = false,
			safe_output = true,
			click = false,
			lsp = {
				auto_attach = true,
				preference = {
					"jedi_language_server",
					"ruff_lsp",
				},
			},
		},
	},
}
