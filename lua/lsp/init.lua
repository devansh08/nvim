local M = {}

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
    { name = "DiagnosticSignHint", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    signs = {
      active = signs,
    },
    underline = true,
    update_in_insert = true,
    virtual_text = {
      spacing = 4,
      source = true,
    },
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

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {})
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

  if client.name == "pyright" then
    -- Use jedi for pydocs in hover
    client.config.capabilities.textDocument.hover = nil
    client.server_capabilities.hoverProvider = nil
  end
end

local status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status then
  print("Error: require cmp_nvim_lsp failed")
  return M
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
M.capabilities = vim.tbl_deep_extend("force", cmp_nvim_lsp.default_capabilities(), capabilities)

return M
