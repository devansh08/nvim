return {
	{
		"windwp/nvim-autopairs",
		branch = "master",
		lazy = true,
		event = "BufWritePre",
		config = function()
			local opts = {
				disable_filetype = { "TelescopePrompt" },
				enable_check_bracket_line = false,
				check_ts = true,
				ts_config = {
					lua = { "string", "source", "string_content" },
					javascript = { "string", "template_string" },
				},
				fast_wrap = {
					map = "<C-f>",
					chars = { "{", "[", "(", '"', "'" },
					pattern = [=[[%'%"%>%]%)%}%,]]=],
					end_key = "$",
					keys = "qwertyuiopzxcvbnmasdfghjkl",
					check_comma = true,
					manual_position = true,
					highlight = "Search",
					highlight_grey = "Comment",
				},
			}

			require("nvim-autopairs").setup(opts)

			local cmp_autopairs = require("nvim-autopairs.completion.cmp")

			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
	{
		"numToStr/Comment.nvim",
		branch = "master",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			padding = true,
			sticky = true,
			ignore = nil,
			mappings = {
				basic = false,
				extra = false,
			},
			pre_hook = function(ctx)
				local U = require("Comment.utils")

				local location = nil
				if ctx.ctype == U.ctype.block then
					location = require("ts_context_commentstring.utils").get_cursor_location()
				elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
					location = require("ts_context_commentstring.utils").get_visual_start_location()
				end

				return require("ts_context_commentstring.internal").calculate_commentstring({
					key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
					location = location,
				})
			end,
			post_hook = nil,
		},
	},
	{
		"ThePrimeagen/refactoring.nvim",
		branch = "master",
		lazy = true,
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			prompt_func_return_type = {
				go = false,
				java = true,
				cpp = false,
				c = true,
				h = false,
				hpp = false,
				cxx = false,
			},
			prompt_func_param_type = {
				go = false,
				java = true,
				cpp = false,
				c = true,
				h = false,
				hpp = false,
				cxx = false,
			},
			printf_statements = {},
			print_var_statements = {},
		},
	},
	{
		"tpope/vim-abolish",
		branch = "master",
		lazy = true,
		event = "BufReadPre",
	},
	{
		"NvChad/nvim-colorizer.lua",
		branch = "master",
		lazy = true,
		ft = { "css", "scss", "html" },
		config = function()
			require("colorizer").setup({
				filetypes = { "css", "scss", "html" },
				user_default_options = {
					css = true,
					css_fn = true,
					mode = "background",
					tailwind = true,
					sass = { enable = true, parsers = { "css" } },
					virtualtext = "■",
					always_update = true,
				},
				buftypes = {},
			})
		end,
	},
	{
		"axelvc/template-string.nvim",
		branch = "main",
		lazy = true,
		ft = { "html", "typescript", "javascript", "typescriptreact", "javascriptreact", "python" },
		config = function()
			require("template-string").setup({
				filetypes = {
					"html",
					"typescript",
					"javascript",
					"typescriptreact",
					"javascriptreact",
					"python",
				},
				jsx_brackets = true,
				remove_template_string = true,
				restore_quotes = {
					normal = [["]],
					jsx = [["]],
				},
			})
		end,
	},
	{
		"yorickpeterse/nvim-pqf",
		branch = "main",
		lazy = true,
		ft = { "qf" },
		opts = {
			signs = {
				error = "",
				warning = "",
				info = "",
				hint = "",
			},
			show_multiple_lines = false,
			max_filename_length = 0,
		},
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")

			harpoon:setup({
				["default"] = {
					select = function(list_item, list, options)
						local filename = string.gsub(list_item.value, "%s+", "\\ ")
						if options ~= nil then
							if options.split then
								vim.cmd("split " .. filename)
							elseif options.vsplit then
								vim.cmd("vsplit " .. filename)
							end
						else
							vim.cmd("tab :drop " .. filename)
						end
					end,
				},
			})

			vim.keymap.set("n", "<leader>ha", function()
				harpoon:list():append()
			end, { noremap = true, silent = true, desc = "Harpoon: Add File to List" })
			vim.keymap.set("n", "<C-o>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end, { noremap = true, silent = true, desc = "Harpoon: Toggle Quick Menu" })
			vim.keymap.set("n", "<leader>h<Right>", function()
				harpoon:list():next()
			end, { noremap = true, silent = true, desc = "Harpoon: Jump to Next File in List" })
			vim.keymap.set("n", "<leader>h<Left>", function()
				harpoon:list():prev()
			end, { noremap = true, silent = true, desc = "Harpoon: Jump to Prev File in List" })
			vim.keymap.set("n", "<A-a>", function()
				harpoon:list():select(1)
			end, { noremap = true, silent = true, desc = "Harpoon: Jump to File 1 in List" })
			vim.keymap.set("n", "<A-s>", function()
				harpoon:list():select(2)
			end, { noremap = true, silent = true, desc = "Harpoon: Jump to File 2 in List" })
			vim.keymap.set("n", "<A-d>", function()
				harpoon:list():select(3)
			end, { noremap = true, silent = true, desc = "Harpoon: Jump to File 3 in List" })
			vim.keymap.set("n", "<A-f>", function()
				harpoon:list():select(4)
			end, { noremap = true, silent = true, desc = "Harpoon: Jump to File 4 in List" })
			vim.keymap.set("n", "<A-g>", function()
				harpoon:list():select(5)
			end, { noremap = true, silent = true, desc = "Harpoon: Jump to File 5 in List" })

			harpoon:extend({
				UI_CREATE = function(cx)
					vim.cmd([[ call feedkeys("\<Esc>", "n") ]])
					vim.keymap.set("n", "<C-v>", function()
						harpoon.ui:select_menu_item({ vsplit = true })
					end, { buffer = cx.bufnr })

					vim.keymap.set("n", "<C-x>", function()
						harpoon.ui:select_menu_item({ split = true })
					end, { buffer = cx.bufnr })
				end,
			})
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			signs = true,
			sign_priority = 8,
			keywords = {
				FIX = {
					icon = " ",
					color = "error",
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
				},
				TODO = { icon = " ", color = "info", alt = { "TRY", "EXPLORE" } },
				HACK = { icon = " ", color = "warning" },
				WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
				TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
			},
			gui_style = {
				fg = "NONE",
				bg = "BOLD",
			},
			merge_keywords = true,
			highlight = {
				multiline = true,
				multiline_pattern = "^.",
				multiline_context = 10,
				before = "",
				keyword = "wide",
				after = "fg",
				pattern = [[.*<(KEYWORDS)\s*:]],
				comments_only = true,
				max_line_len = 400,
				exclude = {},
			},
			colors = {
				error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
				warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
				info = { "DiagnosticInfo", "#2563EB" },
				hint = { "DiagnosticHint", "#10B981" },
				default = { "Identifier", "#7C3AED" },
				test = { "Identifier", "#FF00FF" },
			},
			search = {
				command = "rg",
				args = {
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
				},
				pattern = [[\b(KEYWORDS):]],
			},
		},
	},
	{
		"mbbill/undotree",
		branch = "master",
		config = function()
			vim.g.undotree_WindowLayout = 3
			vim.g.undotree_ShortIndicators = 1
			vim.g.undotree_SetFocusWhenToggle = 1
			vim.g.undotree_SplitWidth = 40
		end,
	},
}
