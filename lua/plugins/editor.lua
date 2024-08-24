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
				if ctx.ctype == U.ctype.blockwise then
					location = require("ts_context_commentstring.utils").get_cursor_location()
				elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
					location = require("ts_context_commentstring.utils").get_visual_start_location()
				end

				local key = ctx.ctype == U.ctype.linewise and "__default" or "__multiline"
				if vim.bo.filetype == "lua" then
					key = "__default"
				end

				return require("ts_context_commentstring.internal").calculate_commentstring({
					key = key,
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
				TEST = { icon = "󰤑 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
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
	{
		"mg979/vim-visual-multi",
		branch = "master",
		-- https://github.com/mg979/vim-visual-multi/issues/241#issuecomment-1575139717
		init = function()
			vim.g.VM_maps = {
				["Add Cursor Down"] = "<M-j>",
				["Add Cursor Up"] = "<M-k>",
				["Select h"] = "<M-h>",
				["Select l"] = "<M-l>",
			}
			vim.g.VM_custom_motions = {
				["<Left>"] = "h",
				["<Right>"] = "l",
				["<Up>"] = "k",
				["<Down>"] = "j",
			}
			vim.g.VM_theme = "sand"
			vim.g.VM_set_statusline = 1
			vim.g.VM_silent_exit = 1
		end,
	},
}
