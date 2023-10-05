return {
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
			},
			lualine_c = { "filename" },
			lualine_x = { "filetype" },
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
					fmt = function(name, context)
						-- Show + if buffer is modified in tab
						local buflist = vim.fn.tabpagebuflist(context.tabnr)
						local winnr = vim.fn.tabpagewinnr(context.tabnr)
						local bufnr = buflist[winnr]
						local mod = vim.fn.getbufvar(bufnr, "&mod")

						return name .. (mod == 1 and " " or "")
					end,

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
			lualine_c = {},
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
		},
	},
}

