require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.commands")

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

-- Load plugins from lua/plugins/*.lua files
require("lazy").setup({
  spec = {
    { import = "plugins" },
    { import = "plugins.languages" },
    { import = "plugins.dap-extensions" },
  },
  ui = {
    border = "rounded",
  },
  change_detection = {
    notify = false,
  },
})
