return {
	{
		"hrsh7th/nvim-cmp",
		branch = "main",
		lazy = true,
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				branch = "master",
				lazy = true,
				dependencies = {
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
			},
			{
				"hrsh7th/cmp-nvim-lsp-signature-help",
				lazy = true,
				branch = "main",
			},
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
					["<Up>"] = cmp.mapping.select_prev_item(),
					["<Down>"] = cmp.mapping.select_next_item(),
					["<C-Up>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
					["<C-Down>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),

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
							cmp.select_next_item()
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
					{ name = "nvim_lua" },
					{ name = "nvim_lsp" },
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
							nvim_lua = "[NeoVim Lua]",
							nvim_lsp = "[LSP]",
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
}
