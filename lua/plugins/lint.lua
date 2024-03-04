return {
	{
		"mfussenegger/nvim-lint",
		lazy = true,
		event = "BufWritePre",
		config = function()
			require("lint").linters_by_ft = {
				c = { "cpplint" },
				cpp = { "cpplint" },
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				kotlin = { "ktlint" },
				go = { "revive" },
				python = { "ruff" },
			}
		end,
	},
}
