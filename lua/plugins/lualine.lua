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
				lualine_a = {
					"mode",
					function()
						if vim.g.Vm and vim.b.visual_multi == 1 then
							if vim.g.Vm.extend_mode == 0 then
								return "CURSOR"
							else
								return "EXTEND"
							end
						end

						return ""
					end,
				},
				lualine_b = {
					"branch",
					"diff",
					{
						"diagnostics",
						update_in_insert = true,
					},
				},
				lualine_c = {
					{
						"filename",
						file_status = true,
						newfile_status = false,
						path = 0,
						symbols = {
							modified = "",
						},
					},
				},
				lualine_x = {
					function()
						local clients = vim.lsp.get_clients()
						if next(clients) == nil then
							return ""
						end

						local names = {}
						for _, client in pairs(clients) do
							table.insert(names, client.name)
						end
						return "󰒋 " .. table.concat(names, "|")
					end,
					function()
						local status, lint = pcall(require, "lint")
						if not status then
							return ""
						end

						local linters = lint._resolve_linter_by_ft(vim.bo.filetype)
						if #linters == 0 then
							return ""
						else
							return "󰏫 " .. table.concat(linters, "|")
						end
					end,
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					{
						"filename",
						file_status = true,
						newfile_status = false,
						path = 0,
						symbols = {
							modified = "",
						},
					},
				},
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
				lualine_y = { "selectioncount" },
				lualine_z = { "searchcount" },
			},
			winbar = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			inactive_winbar = {
				lualine_a = {},
        lualine_b = {},
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
		event = "BufReadPost",
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
				},
			},
		},
	},
}
