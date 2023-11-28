return {
	"nvimtools/none-ls.nvim",
	branch = "main",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local null_ls = require("null-ls")
		local custom_utils = require("utils")
		local add_null_ls_source = custom_utils.add_null_ls_source

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
			sources = add_null_ls_source(null_ls, {
				{
					code_actions = {
						{
							"eslint_d",
							{
								condition = function(utils)
									return utils.root_has_file({ ".eslintrc.js", ".eslintrc.json" })
										and not utils.root_has_file(".ignore-ca")
								end,
							},
						},
					},
				},
				{
					diagnostics = {
						{
							"cpplint",
							{
								filter = function(diagnostic)
									if
										vim.bo.filetype == "c"
										and string.find(diagnostic.message, "Using C%-style cast") ~= nil
									then
										return false
									end
									return true
								end,
								condition = function(utils)
									return not utils.root_has_file(".ignore-diag")
								end,
							},
						},
						{
							"eslint_d",
							{
								condition = function(utils)
									return utils.root_has_file({ ".eslintrc.js", ".eslintrc.json" })
										and not utils.root_has_file(".ignore-diag")
								end,
							},
						},
						{ "fish" },
						{ "ktlint" },
						{ "revive" },
						{ "ruff" },
						{
							"tsc",
							{
								condition = function(utils)
									return (
										utils.root_has_file({ "package.json", "package-lock.json" })
										or utils.root_has_file({ "package.json", "bun.lockb" })
									) and not utils.root_has_file(".ignore-diag")
								end,
							},
						},
					},
				},
				{
					formatting = {
						{ "black" },
						{ "clang_format" },
						{ "fish_indent" },
						{ "goimports" },
						{ "google_java_format" },
						{ "jq" },
						{ "ktlint" },
						{
							"prettierd",
							{
								condition = function(utils)
									return utils.root_has_file({ ".prettierrc", ".prettierrc.json" })
										and not utils.root_has_file(".ignore-fmt")
								end,
							},
						},
						{ "shfmt" },
						{ "stylua" },
						{ "taplo" },
					},
				},
			}),
			update_in_insert = true,
		})
	end,
}
