local set_keymaps = require("utils").set_keymaps

local cmd_opts = require("constants").CMD_OPTS

-- Reload currently edited config (lua/config/*.lua) file
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "**/lua/config/*.lua",
	callback = function()
		dofile(vim.fn.expand("%"))
	end,
	group = vim.api.nvim_create_augroup("ReloadConfig", { clear = true }),
})

-- Better help navigation
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	callback = function()
	end,
	group = vim.api.nvim_create_augroup("HelpNavigation", { clear = true }),
})

-- Auto switch to file buffer when changing windows or close nvim-tree buffer if it is the last buffer
vim.api.nvim_create_autocmd("WinLeave", {
	callback = function()
		if vim.bo.filetype == "NvimTree" or vim.bo.filetype == "trouble" then
			if vim.fn.tabpagewinnr(vim.fn.tabpagenr(), "$") == 1 then
				vim.cmd("q")
			else
				vim.cmd("wincmd p")
			end
		end
	end,
	group = vim.api.nvim_create_augroup("AutoSwitchNvimTreeBuffer", { clear = true }),
})

-- Setup LSP keymaps when LSP is attached to buffer
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function()
		local keymaps = {
			-- Displays hover information about the symbol under the cursor
			["<leader>lh"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "LSP: Show Hover Info" },

			-- Jump to definition
			["<leader>ldf"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", "LSP: Jump to Definition" },

			-- Jump to declaration
			["<leader>ldc"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "LSP: Jump to Declaration" },

			-- Lists all the implementations for the symbol under the cursor
			["<leader>li"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "LSP: List Implementations" },

			-- Jumps to the definition of the type symbol
			["<leader>lt"] = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "LSP: Jump to Type Definition" },

			-- Lists all the references
			["<leader>lR"] = { "<cmd>lua vim.lsp.buf.references()<cr>", "LSP: List References" },

			-- Displays a function's signature information
			["<leader>ls"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "LSP: Show Signature Info" },

			-- Renames all references to the symbol under the cursor
			["<leader>lr"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "LSP: Rename References" },

			-- Selects a code action available at the current cursor position
			["<leader>lc"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "LSP: Show Code Actions" },

			-- Format code in buffer
			["<leader>lf"] = {
				"<cmd>lua vim.lsp.buf.format({ async = false })<cr>:w<cr>",
				"LSP: Format Code in Buffer",
			},

			-- Show diagnostics in a floating window
			["<leader>lg"] = { "<cmd>lua vim.diagnostic.open_float()<cr>", "LSP: Show Diagnostics for Current Line" },

			-- Move to the previous diagnostic
			["<leader>lp"] = {
				"<cmd>lua vim.diagnostic.goto_prev()<cr>",
				"LSP: Jump to Previous Line with Diagnostics",
			},

			-- Move to the next diagnostic
			["<leader>ln"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "LSP: Jump to Next Line with Diagnostics" },
		}

		set_keymaps("n", keymaps, cmd_opts, true)
	end,
	group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),
})

-- Run linter (nvim-lint) after write
vim.api.nvim_create_autocmd("BufWritePost", {
	callback = function()
		local ft = vim.bo.filetype
		local file_exists_in_root = require("utils").file_exists_in_root
		local table_contains = require("utils").table_contains

		if table_contains({ "javascript", "typescript", "javascriptreact", "typescriptreact" }, ft) then
			if file_exists_in_root(".eslintrc") or file_exists_in_root(".eslintrc.js") then
				require("lint").try_lint()
			end
		else
			require("lint").try_lint()
		end
	end,
	group = vim.api.nvim_create_augroup("RunLintOnSave", { clear = true }),
})

-- Highlight yanked text temporarily after yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ timeout = 250 })
	end,
	group = vim.api.nvim_create_augroup("HighlightOnYank", { clear = true }),
})
