return {
	{
		"mfussenegger/nvim-lint",
		lazy = true,
		event = "BufWritePre",
		config = function()
			require("lint").linters_by_ft = {
				bash = { "bash" },
				c = { "cpplint" },
				cpp = { "cpplint" },
				go = { "revive" },
				javascript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				kotlin = { "ktlint" },
				typescript = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				python = { "ruff" },
				sh = { "bash" },
			}
		end,
	},
}
