require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Setup lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
    { import = "plugins"},
    { import = "plugins.languages"},
  },
  ui = {
    border = "single",
  },
  change_detection = {
    notify = false,
  },
})

require("lsp").setup()
