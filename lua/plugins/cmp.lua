return {
	{
		"rafamadriz/friendly-snippets",
		branch = "main",
		lazy = true,
	},
	{
		"saadparwaiz1/cmp_luasnip",
		branch = "master",
		lazy = true,
	},
	{
		"L3MON4D3/LuaSnip",
		version = "*",
		lazy = true,
		build = "make install_jsregexp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load({
				paths = vim.fn.stdpath("data") .. "/lazy/friendly-snippets",
			})
		end,
	},
	{
		"onsails/lspkind.nvim",
		branch = "master",
		lazy = true,
	},
	{
		"hrsh7th/cmp-buffer",
		branch = "main",
		lazy = true,
	},
	{
		"hrsh7th/cmp-path",
		branch = "main",
		lazy = true,
	},
	{
		"hrsh7th/cmp-nvim-lua",
		branch = "main",
		lazy = true,
	},
	{
		"hrsh7th/cmp-nvim-lsp",
		branch = "main",
		lazy = true,
	},
	{
		"hrsh7th/nvim-cmp",
		branch = "main",
		lazy = true,
		event = "InsertEnter",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"onsails/lspkind.nvim",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"windwp/nvim-autopairs",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			cmp.setup({
				preselect = cmp.PreselectMode.None,
				snippet = {
					expand = function(args)
						-- Use LuaSnip as Snippet Engine for nvim-cmp
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = {
					["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
					["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
					["<C-Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select, count = 5 }),
					["<C-Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select, count = 5 }),
					["<S-Up>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
					["<S-Down>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),

					-- Open completion menu
					["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "s" }),
					["<Esc>"] = cmp.mapping({
						i = cmp.mapping.abort(),
						c = cmp.mapping.close(),
					}),

					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
					}),

					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							if #cmp.get_entries() == 1 then
								cmp.confirm({ select = true })
							else
								cmp.select_next_item()
							end
						elseif luasnip.expandable() then
							luasnip.expand()
						elseif luasnip.jumpable(1) then
							luasnip.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						end
						if luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "nvim_lsp_signature_help" },
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = lspkind.cmp_format({
						mode = "symbol",
						menu = {
							nvim_lsp = "[LSP]",
							nvim_lua = "[NeoVim Lua]",
							buffer = "[Buffer]",
							path = "[Path]",
							luasnip = "[LuaSnip]",
							nvim_lsp_signature_help = "[Signature]",
						},
					}),
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
			})
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		branch = "master",
		lazy = true,
		event = "LspAttach",
		config = function()
			require("lsp_signature").setup({
				hint_enable = false,
				handler_opts = {
					border = "rounded",
				},
				transparency = nil,
				close_timeout = 1000,
				auto_close_after = 1000,
			})
		end,
	},
}
