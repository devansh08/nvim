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
					border = "rounded",
				},
				--log_level = vim.log.levels.TRACE,
			}

			require("mason").setup(opts)

			local utils = require("utils")
			local check_executable = utils.check_executable

			-- Long names
			local ensure_installed = check_executable({
				["angular-language-server"] = { { "node", "npm" }, { "bun" } },
				["bash-language-server"] = { { "bash" } },
				["clang-format"] = { { "gcc" }, { "g++" } },
				["clangd"] = { { "gcc" }, { "g++" } },
				["cpplint"] = { { "g++" } },
				["debugpy"] = { { "python", "pip" } },
				["dockerfile-language-server"] = { { "docker" }, { "pulumi" } },
				["eslint_d"] = { { "node", "npm" }, { "bun" } },
				["google-java-format"] = { { "java" } },
				["gopls"] = { { "go" } },
				["jdtls"] = { { "java" } },
				["jedi-language-server"] = { { "python", "pip" } },
				["js-debug-adapter"] = { { "node", "npm" }, { "bun" } },
				["json-lsp"] = {},
				["kotlin-language-server"] = { { "kotlin", "kotlinc" } },
				["ktlint"] = { { "kotlin", "kotlinc" } },
				["lua-language-server"] = { { "lua" } },
				["marksman"] = {},
				["prettierd"] = { { "node", "npm" }, { "bun" } },
				["revive"] = { { "go" } },
				["ruff"] = { { "python", "pip" } },
				["ruff-lsp"] = { { "python", "pip" } },
				["shfmt"] = { { "bash" } },
				["stylua"] = { { "lua" } },
				["taplo"] = {},
				["typescript-language-server"] = { { "node", "npm" }, { "bun" } },
				["yaml-language-server"] = {},
			})

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
