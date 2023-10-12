return {
	{
		-- Depends on cmp and treesitter
		"windwp/nvim-autopairs",
		branch = "master",
		lazy = true,
		event = "InsertEnter",
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
			-- pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
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
}
