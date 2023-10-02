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

}

for k, v in pairs(options) do
	vim.opt[k] = v
end
