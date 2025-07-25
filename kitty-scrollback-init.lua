vim.opt.number = false
vim.opt.list = false
vim.opt.showtabline = 0
vim.opt.cmdheight = 0
vim.opt.foldcolumn = "0"
vim.opt.laststatus = 0
vim.opt.clipboard = "unnamedplus"
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  command = "normal G",
})

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 250 })
  end,
})

vim.api.nvim_set_keymap("t", "q", ":qa!<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "q", ":qa!<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "a", ":qa!<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "a", ":qa!<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "i", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "I", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "A", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "o", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "O", "<Nop>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<C-Up>", "5k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Down>", "5j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Left>", "b", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Right>", "e", { noremap = true, silent = true })

vim.api.nvim_set_keymap("v", "<C-Up>", "5k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-Down>", "5j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-Left>", "b", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-Right>", "e", { noremap = true, silent = true })
