local options = {
	number = true,
	cursorline = true,

	mouse = "a",
	clipboard = "unnamedplus",

	splitbelow = true,
	splitright = true,

	scrolloff = 8,
	sidescrolloff = 20,
	wrap = false,

	completeopt = { "menuone", "preview", "noselect" },
	pumheight = 20,
	updatetime = 300,

	hlsearch = true,
	incsearch = true,
	ignorecase = true,
	smartcase = true,

	smartindent = true,
	autoindent = true,
	expandtab = true,
	shiftwidth = 2,
	tabstop = 2,

	undofile = true,

	termguicolors = true,

  -- For tree-sitter folding
	foldmethod = "expr",
	foldexpr = "vim.treesitter.foldexpr()",
	foldenable = true,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.opt.iskeyword:remove({ "-", "_" })
vim.opt.whichwrap:append({
	["<"] = true,
	[">"] = true,
	["["] = true,
	["]"] = true,
})

vim.cmd([[ command! Q q ]])
vim.cmd([[ command! W w ]])
vim.cmd([[ command! Wq wq ]])

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
