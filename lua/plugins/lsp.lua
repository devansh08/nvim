return {
	{
		-- Mason extension to use with nvim-lspconfig
		"williamboman/mason-lspconfig.nvim",
		tag = "stable",
		lazy = true,
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
				if lsp_server_names and skip_default_config and lsp_server_names[i] == skip_default_config[j] then
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
	-- NeoVim LSP Server Configs
	{
		-- NOTE: Server setup directly by nvim-lspconfig needs to be done after mason-lspconfig is done setting up servers
		"neovim/nvim-lspconfig",
		branch = "master",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
	},
	{
		"j-hui/fidget.nvim",
		version = "*",
		config = function()
			local opts = {
				progress = {
					poll_rate = 0,
					suppress_on_insert = false,
					ignore_done_already = false,
					ignore_empty_message = false,

					clear_on_detach = function(client_id)
						local client = vim.lsp.get_client_by_id(client_id)
						return client and client.name or nil
					end,

					notification_group = function(msg)
						return msg.lsp_client.name
					end,
					ignore = {},

					display = {
						render_limit = 16,
						done_ttl = 3,
						done_icon = "✔",
						done_style = "Constant",
						progress_ttl = math.huge,

						progress_icon = { pattern = "dots", period = 1 },

						progress_style = "WarningMsg",
						group_style = "Title",
						icon_style = "Question",
						priority = 30,
						skip_history = true,

						format_message = require("fidget.progress.display").default_format_message,

						format_annote = function(msg)
							return msg.title
						end,

						format_group_name = function(group)
							return tostring(group)
						end,
					},

					lsp = {
						progress_ringbuf_size = 0,
						log_handler = false,
					},
				},

				notification = {
					poll_rate = 10,
					filter = vim.log.levels.INFO,
					history_size = 128,
					override_vim_notify = false,

					configs = { default = require("fidget.notification").default_config },

					redirect = function(msg, level, opts)
						if opts and opts.on_open then
							return require("fidget.integration.nvim-notify").delegate(msg, level, opts)
						end
					end,

					view = {
						stack_upwards = true,
						icon_separator = " ",
						group_separator = "---",

						group_separator_hl = "Comment",

						render_message = function(msg, cnt)
							return cnt == 1 and msg or string.format("(%dx) %s", cnt, msg)
						end,
					},

					window = {
						normal_hl = "Comment",
						winblend = 0,
						border = "none",
						zindex = 45,
						max_width = 0,
						max_height = 0,
						x_padding = 1,
						y_padding = 0,
						align = "bottom",
						relative = "editor",
					},
				},

				integration = {
					["nvim-tree"] = {
						enable = true,
					},
				},

				logger = {
					level = vim.log.levels.WARN,
					max_size = 10000,
					float_precision = 0.01,

					path = string.format("%s/fidget.nvim.log", vim.fn.stdpath("cache")),
				},
			}
			require("fidget").setup(opts)
		end,
	},
}
