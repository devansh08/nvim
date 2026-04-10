local constants = require("constants")

vim.opt.runtimepath:append(constants.NVIM_LOCAL .. "/lazy/nvim-lspconfig")

if not string.find(vim.env.PATH, constants.MASON_BIN, 1, true) then
  vim.env.PATH = constants.MASON_BIN .. ":" .. vim.env.PATH
end

local ERROR = vim.diagnostic.severity.ERROR
local WARN = vim.diagnostic.severity.WARN
local INFO = vim.diagnostic.severity.INFO
local HINT = vim.diagnostic.severity.HINT

vim.diagnostic.config({
  signs = {
    text = {
      [ERROR] = "",
      [WARN] = "",
      [INFO] = "",
      [HINT] = "",
    },
    linehl = {},
  },
  jump = {
    severity = {
      min = WARN,
    },
    wrap = true,
  },
  underline = true,
  severity_sort = true,
  float = {
    border = "single",
    scope = "line",
    source = true,
  },
  virtual_text = false,
  virtual_lines = {
    current_line = true,
    severity = ERROR,
  },
})

local lsp_servers = {
  "bashls",
  "cssls",
  "dockerls",
  "gopls",
  "html",
  "lua_ls",
  "marksman",
  "taplo",
  "ts_ls",
}

local lspCapabilitiesFile = constants.NVIM_LOCAL .. "/blink/lsp_capabilities.lua"
local blinkLspCapabilities = dofile(lspCapabilitiesFile)

vim.lsp.config("*", {
  capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), blinkLspCapabilities),
})

local lsp_settings_dir = constants.NVIM_CONFIG .. "/lua/lsp/settings/"
local lsp_settings_files = vim.fn.readdir(lsp_settings_dir)
for _, file in ipairs(lsp_settings_files) do
  local ok, settings = pcall(require, "lsp.settings." .. file:gsub("%.lua$", ""))
  if ok then
    local server_name = file:gsub("%.lua$", "")
    vim.lsp.config(server_name, settings)
  else
    print("[config.lsp] Error loading settings for " .. file .. ": " .. vim.inspect(settings))
  end
end

vim.lsp.enable(lsp_servers)
