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
		vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<C-]>", { noremap = true })
		vim.api.nvim_buf_set_keymap(0, "n", "<BS>", "<C-T>", { noremap = true })
	end,
	group = vim.api.nvim_create_augroup("HelpNavigation", { clear = true }),
})

-- Auto open nvim-tree on startup
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function(data)
		local real_file = vim.fn.filereadable(data.file) == 1
		local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

		if not real_file and not no_name then
			return
		end

		local status, nvim_tree_api = pcall(require, "nvim-tree.api")
		if not status then
			print("Error: require nvim-tree.api failed")
			return
		end

		if nvim_tree_api.toggle ~= nil then
			nvim_tree_api.toggle({ focus = false, find_file = true })
		end
	end,
	group = vim.api.nvim_create_augroup("AutoStartNvimTree", { clear = true }),
})

-- Auto switch to file buffer when changing windows or close nvim-tree buffer if it is the last buffer
vim.api.nvim_create_autocmd("WinLeave", {
	callback = function()
		if vim.bo.filetype == "NvimTree" then
			if vim.fn.tabpagewinnr(vim.fn.tabpagenr(), "$") == 1 then
				vim.cmd("q")
			else
				vim.cmd("wincmd p")
			end
		end
	end,
	group = vim.api.nvim_create_augroup("SwitchAwayFromNvimTreeBuffer", { clear = true }),
})

-- Setup LSP keymaps when LSP is attached to buffer
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function()
		local keymap = vim.api.nvim_buf_set_keymap

		local keymaps = {
			-- Displays hover information about the symbol under the cursor
			["h"] = "<cmd>lua vim.lsp.buf.hover()<cr>",

			-- Jump to definition
			["df"] = "<cmd>lua vim.lsp.buf.definition()<cr>",

			-- Jump to declaration
			["dc"] = "<cmd>lua vim.lsp.buf.declaration()<cr>",

			-- Lists all the implementations for the symbol under the cursor
			["i"] = "<cmd>lua vim.lsp.buf.implementation()<cr>",

			-- Jumps to the definition of the type symbol
			["t"] = "<cmd>lua vim.lsp.buf.type_definition()<cr>",

			-- Lists all the references
			["R"] = "<cmd>lua vim.lsp.buf.references()<cr>",

			-- Displays a function's signature information
			["s"] = "<cmd>lua vim.lsp.buf.signature_help()<cr>",

			-- Renames all references to the symbol under the cursor
			["r"] = "<cmd>lua vim.lsp.buf.rename()<cr>",

			-- Selects a code action available at the current cursor position
			["c"] = "<cmd>lua vim.lsp.buf.code_action()<cr>",

			-- Format code in buffer
			["f"] = "<cmd>lua vim.lsp.buf.format({ async = false })<cr>:w<cr>",

			-- Show diagnostics in a floating window
			["g"] = "<cmd>lua vim.diagnostic.open_float()<cr>",

			-- Move to the previous diagnostic
			["p"] = "<cmd>lua vim.diagnostic.goto_prev()<cr>",

			-- Move to the next diagnostic
			["n"] = "<cmd>lua vim.diagnostic.goto_next()<cr>",
		}

		for k, v in pairs(keymaps) do
			keymap(0, "n", "<leader>l" .. k, v, { noremap = true })
		end
	end,
	group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),
})
