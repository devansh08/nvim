return {
	"nvimtools/none-ls.nvim",
	branch = "main",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			border = "rounded",
			diagnostics_format = "[#{c}] #{m}",
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							if vim.g.no_format ~= true then
								vim.lsp.buf.format({ async = false })
							else
								vim.g.no_format = false
							end
						end,
						group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = true }),
					})
				end
			end,
			sources = {
				null_ls.builtins.code_actions.eslint_d,
				null_ls.builtins.code_actions.gitsigns.with({
					config = {
						-- Remove specific actions from suggestions
						filter_actions = function(title)
							return title:lower():match("blame") == nil
						end,
					},
				}),

				null_ls.builtins.diagnostics.eslint_d,
				null_ls.builtins.diagnostics.fish,
				null_ls.builtins.diagnostics.ruff,
				null_ls.builtins.diagnostics.tsc,

				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.fish_indent,
				null_ls.builtins.formatting.google_java_format,
				null_ls.builtins.formatting.jq,
				null_ls.builtins.formatting.prettierd,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.taplo,
			},
      update_in_insert = true,
		})
	end,
}
