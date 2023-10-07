return {
	-- NeoVim LSP Server Configs
	{
		-- NOTE: Server setup directly by nvim-lspconfig needs to be done after mason-lspconfig is done setting up servers
		"neovim/nvim-lspconfig",
		branch = "master",
		dependencies = {
			{
				-- Mason extension to use with nvim-lspconfig
				"williamboman/mason-lspconfig.nvim",
				tag = "stable",
				config = function()
					-- lua/lsp/init.lua
					local lsp_defaults = require("lsp.init")

					local lspconfig = require("lspconfig")
					local mason_lspconfig = require("mason-lspconfig")

					mason_lspconfig.setup()

					local lsp_server_names = mason_lspconfig.get_installed_servers()
					local skip_default_config = { "jdtls" }
					local disable_servers = {}

					table.sort(lsp_server_names)
					table.sort(skip_default_config)
					table.sort(disable_servers)

					local j = #skip_default_config
					local k = #disable_servers
					local deleteFlag = false
					for i = #lsp_server_names, 1, -1 do
						if
							lsp_server_names
							and skip_default_config
							and lsp_server_names[i] == skip_default_config[j]
						then
							deleteFlag = true
							j = j - 1
						end
						if lsp_server_names and disable_servers and lsp_server_names[i] == disable_servers[k] then
							deleteFlag = true
							k = k - 1
						end

						if deleteFlag then
							table.remove(lsp_server_names, i)
							deleteFlag = false
						end
					end

					if lsp_server_names then
						for _, server in ipairs(lsp_server_names) do
							local opts = {
								on_attach = lsp_defaults.on_attach,
								capabilities = lsp_defaults.capabilities,
							}

							-- Short names
							local _ok, server_opts = pcall(require, "lsp.settings." .. server)
							if _ok then
								opts = vim.tbl_deep_extend("force", server_opts, opts)
							end
							lspconfig[server].setup(opts)
						end
					end
				end,
			},
		},
	},
}
