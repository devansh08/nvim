local M = {}

M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = true,
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		underline = true,
		update_in_insert = true,
		virtual_text = {
			spacing = 5,
			severity_limit = "Warning",
		},
	})
end

M.on_attach = function(client)
	-- Client specific config to be set on_attach
	if client.server_capabilities.documentHighlightProvider then
		local lsp_augroup = vim.api.nvim_create_augroup("LspDocHighlight", { clear = true })

    vim.api.nvim_create_autocmd("CursorHold", {
			callback = function()
				vim.lsp.buf.document_highlight()
			end,
			group = lsp_augroup,
			buffer = 0,
		})

    vim.api.nvim_create_autocmd("CursorMoved", {
			callback = function()
				vim.lsp.buf.clear_references()
			end,
			group = lsp_augroup,
			buffer = 0,
		})
	end
end

local status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status then
  print("Error: require cmp_nvim_lsp failed")
  return M
end
M.capabilities = cmp_nvim_lsp.default_capabilities()

return M

