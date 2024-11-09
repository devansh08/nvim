local set_keymaps = require("utils").set_keymaps

local opts = require("constants").OPTS

local keymaps = {
	["<CR>"] = { "<Plug>(neorg.esupports.hop.hop-link.drop)", "Neorg: Jump to Link" },
	["<C-Space>"] = { "<Plug>(neorg.qol.todo-items.todo.task-cycle)", "Neorg: Cycle over Task Types" },
}

set_keymaps("n", keymaps, opts, true)

vim.opt["foldlevel"] = 99
vim.opt["conceallevel"] = 2
