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
						group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = false }),
					})
				end
			end,
			sources = {
				null_ls.builtins.code_actions.eslint_d.with({
					condition = function(utils)
						return utils.root_has_file({ ".eslintrc.js", ".eslintrc.json" })
					end,
				}),

				null_ls.builtins.diagnostics.cpplint.with({
					filter = function(diagnostic)
						if vim.bo.filetype == "c" and string.find(diagnostic.message, "Using C%-style cast") ~= nil then
							return false
						end
						return true
					end,
				}),
				null_ls.builtins.diagnostics.eslint_d.with({
					condition = function(utils)
						return utils.root_has_file({ ".eslintrc.js", ".eslintrc.json" })
					end,
				}),
				null_ls.builtins.diagnostics.fish,
				null_ls.builtins.diagnostics.ktlint,
				null_ls.builtins.diagnostics.revive,
				null_ls.builtins.diagnostics.ruff,
				null_ls.builtins.diagnostics.tsc,

				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.clang_format,
				null_ls.builtins.formatting.fish_indent,
				null_ls.builtins.formatting.goimports,
				null_ls.builtins.formatting.google_java_format,
				null_ls.builtins.formatting.jq,
				null_ls.builtins.formatting.ktlint,
				null_ls.builtins.formatting.prettierd.with({
					condition = function(utils)
						return utils.root_has_file({ ".prettierrc", ".prettierrc.json" })
					end,
				}),
				null_ls.builtins.formatting.shfmt,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.taplo,
			},
			update_in_insert = true,
		})
	end,
}
