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

