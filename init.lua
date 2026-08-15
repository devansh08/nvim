require("config.built-ins")
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.commands")
require("config.lsp")

-- Setup lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local theme = dofile(vim.env.HOME .. "/.active_theme/nvim.lua")
vim.g.active_colorscheme = theme["colorscheme"]
vim.g.active_colorscheme_variant = theme["variant"]
vim.g.active_colorscheme_accent = theme["accent"]

-- Load plugins from lua/plugins/*.lua files
require("lazy").setup({
  spec = {
    { import = "plugins" },
    { import = "plugins.languages" },
  },
  ui = {
    border = "single",
  },
  change_detection = {
    notify = false,
  },
})

vim.cmd("colorscheme " .. vim.g.active_colorscheme)
