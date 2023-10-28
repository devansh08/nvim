return {
	-- LSP Server package manager
	{
		"williamboman/mason.nvim",
		tag = "stable",
		build = ":MasonUpdate",
		config = function()
			local opts = {
				pip = {
					install_args = { "--timeout", "999" },
				},
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
				--log_level = vim.log.levels.TRACE,
			}

			require("mason").setup(opts)

			-- Long names
			local ensure_installed = {
				"black",
				"clang-format",
				"clangd",
				"cpplint",
				"dockerfile-language-server",
				"eslint_d",
				"google-java-format",
				"jdtls",
				"json-lsp",
				"lua-language-server",
				"prettierd",
				"pyright",
				"ruff",
				"stylua",
				"taplo",
				"typescript-language-server",
			}

			local Package = require("mason-core.package")
			local registry = require("mason-registry")

			registry.refresh()
			for _, v in ipairs(ensure_installed) do
				if not registry.is_installed(v) then
					local package_name, version = Package.Parse(v)
					local pkg = registry.get_package(package_name)

					print("[Mason] Installing package " .. v)
					pkg:install({
						version = version,
					})
				end
			end
		end,
	},
}
