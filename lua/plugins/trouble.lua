return {
	{
		"folke/trouble.nvim",
		tag = "stable",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		---@type trouble.Config
		opts = {
			auto_close = false,
			auto_open = false,
			auto_preview = false,
			auto_refresh = true,
			auto_jump = false,
			focus = true,
			restore = true,
			follow = true,
			indent_guides = true,
			max_items = 200,
			multiline = true,
			pinned = false,
			warn_no_results = true,
			open_no_results = true,
			---@type trouble.Window.opts
			win = {
				type = "split",
				relative = "win",
				size = {
					height = 10,
				},
				position = "bottom",
			},
			---@type trouble.Window.opts
			preview = {
				type = "main",
				scratch = true,
			},
			throttle = {
				refresh = 20,
				update = 10,
				render = 10,
				follow = 100,
				preview = { ms = 100, debounce = true },
			},
			---@type table<string, trouble.Action.spec|false>
			keys = {
				["?"] = "help",
				r = "refresh",
				R = "toggle_refresh",
				q = "close",
				o = "jump_close",
				["<ESC>"] = "cancel",
				["<2-leftmouse>"] = "jump",
				["<C-x>"] = "jump_split",
				["<C-v>"] = "jump_vsplit",
				["}"] = "next",
				["]]"] = "next",
				["{"] = "prev",
				["[["] = "prev",
				dd = "delete",
				d = { action = "delete", mode = "v" },
				i = "inspect",
				p = "preview",
				P = "toggle_preview",
				zo = "fold_open",
				zO = "fold_open_recursive",
				zc = "fold_close",
				zC = "fold_close_recursive",
				za = "fold_toggle",
				zA = "fold_toggle_recursive",
				zm = "fold_more",
				zM = "fold_close_all",
				zr = "fold_reduce",
				zR = "fold_open_all",
				zx = "fold_update",
				zX = "fold_update_all",
				zn = "fold_disable",
				zN = "fold_enable",
				zi = "fold_toggle_enable",
				gb = {
					---@type trouble.Action.spec
					action = function(view)
						view:filter({ buf = 0 }, { toggle = true })
					end,
					desc = "Toggle Current Buffer Filter",
				},
				s = {
					---@type trouble.Action.spec
					action = function(view)
						local f = view:get_filter("severity")
						local severity = ((f and f.filter.severity or 0) + 1) % 5
						view:filter({ severity = severity }, {
							id = "severity",
							template = "{hl:Title}Filter:{hl} {severity}",
							del = severity == 0,
						})
					end,
					desc = "Toggle Severity Filter",
				},
				["<CR>"] = {
					---@type trouble.Action.spec
					action = function(_, ctx)
						---@type trouble.Action.ctx
						local c = ctx
						if c and c.item then
							vim.cmd(":tab drop " .. c.item.filename)
						end
					end,
					desc = "Toggle Current Buffer Filter",
				},
			},
			---@type table<string, trouble.Mode>
			modes = {
				symbols = {
					desc = "document symbols",
					mode = "lsp_document_symbols",
					focus = false,
					pinned = true,
					---@type trouble.Window.opts
					win = {
						position = "right",
						relative = "win",
						size = {
							width = 40,
						},
					},
					filter = {
						["not"] = { ft = "lua", kind = "Package" },
						any = {
							ft = { "help", "markdown" },
							kind = {
								"Class",
								"Constructor",
								"Enum",
								"Field",
								"Function",
								"Interface",
								"Method",
								"Module",
								"Namespace",
								"Package",
								"Property",
								"Struct",
								"Trait",
							},
						},
					},
				},
			},
			icons = {
				---@type trouble.Indent.symbols
				indent = {
					top = "│ ",
					middle = "├╴",
					last = "└╴",
					fold_open = " ",
					fold_closed = " ",
					ws = "  ",
				},
				folder_closed = " ",
				folder_open = " ",
				kinds = {
					Array = " ",
					Boolean = "󰨙 ",
					Class = " ",
					Constant = "󰏿 ",
					Constructor = " ",
					Enum = " ",
					EnumMember = " ",
					Event = " ",
					Field = " ",
					File = " ",
					Function = "󰊕 ",
					Interface = " ",
					Key = " ",
					Method = "󰊕 ",
					Module = " ",
					Namespace = "󰦮 ",
					Null = " ",
					Number = "󰎠 ",
					Object = " ",
					Operator = " ",
					Package = " ",
					Property = " ",
					String = " ",
					Struct = "󰆼 ",
					TypeParameter = " ",
					Variable = "󰀫 ",
				},
			},
		},
	},
}
