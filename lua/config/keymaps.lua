local utils = require("utils")
local lua_fn = utils.lua_fn

-- 'silent' prevents any output messages
local opts = { noremap = true, silent = true }
local cmd_opts = { noremap = true }
-- 'expr' tells vim to get the command from output of a function/expression
local cmd_expr_opts = { noremap = true, expr = true }

local keymap = vim.api.nvim_set_keymap
local function set_keymaps(mode, keymaps, keymap_opts)
	for k, v in pairs(keymaps) do
		keymap(mode, k, v, keymap_opts)
	end
end

-- Set Space to no-op so it can be remapped to Leader
keymap("", "<Space>", "<Nop>", opts)
-- Set Space as Map Leader <leader>
vim.g.mapleader = " "

local leader_keymaps = {
	["<leader>e"] = ":NvimTreeToggle<CR>",

	["<leader>qq"] = ":qa<CR>",
	["<leader>ww"] = ":lua vim.g.no_format = true<CR>:w<CR>",

	["<leader>ll"] = ":Lazy<CR>",

	["<leader>mm"] = ":Mason<CR>",

	["<leader>gs"] = ":Git<CR>",
	["<leader>gc"] = ":Git commit<CR>",
	["<leader>gd"] = ":Git diff<CR>",
	["<leader>gds"] = ":Git diff --staged<CR>",
	["<leader>gpl"] = ":Git pull<CR>",
	["<leader>gph"] = ":lua if vim.fn.input('Push changes ? ') == 'y' then vim.cmd(':redraw'); vim.cmd(':Git push') else vim.cmd(':redraw'); print('Push aborted') end<CR>",
	["<leader>gp"] = ":lua require('gitsigns').preview_hunk()<CR>",
	["<leader>gA"] = ":lua require('gitsigns').stage_buffer()<CR>",
	["<leader>ga"] = ":lua require('gitsigns').stage_hunk()<CR>",
	["<leader>gr"] = ":lua require('gitsigns').reset_hunk()<CR>",
	["<leader>gu"] = ":lua require('gitsigns').undo_stage_hunk()<cr>",
	["<leader>g<Down>"] = ":lua require('gitsigns').next_hunk({ wrap = false, navigation_message = false, preview = false })<cr>",
	["<leader>g<Up>"] = ":lua require('gitsigns').prev_hunk({ wrap = false, navigation_message = false, preview = false })<CR>",
	["<leader>gl"] = ":Telescope git_commits<CR>",
	["<leader>gbl"] = ":Telescope git_bcommits<CR>",
	["<leader>gsl"] = ":Telescope git_stash<CR>",
	["<leader>gg"] = ":9TermExec cmd='lazygit && exit' direction=float name='lazygit'<CR>",

	["<leader>ff"] = ":Telescope find_files<CR>",
	["<leader>fg"] = ":Telescope live_grep<CR>",
	["<leader>fk"] = ":Telescope keymaps<CR>",
	["<leader>fj"] = ":Telescope jumplist<CR>",
	["<leader>fb"] = ":Telescope buffers<CR>",

	["<leader>tt"] = ":TermSelect<CR>",
	["<leader>t1"] = ":1ToggleTerm direction=float<CR>",
	["<leader>t2"] = ":2ToggleTerm direction=float<CR>",
	["<leader>t3"] = ":3ToggleTerm direction=float<CR>",
	["<leader>th"] = ":4ToggleTerm direction=horizontal<CR>",

	["<leader>fr"] = ":Telescope lsp_references<CR>",
	["<leader>fi"] = ":Telescope lsp_implementations<CR>",
	["<leader>fd"] = ":Telescope lsp_definitions<CR>",
	["<leader>fe"] = ":Telescope diagnostics<CR>",
	["<leader>fc"] = ":lua require('telescope.builtin').diagnostics({ bufnr = 0 })<CR>",

	["<leader>jo"] = ":lua require('jdtls').organize_imports()<CR>",
	["<leader>jv"] = ":lua require('jdtls').extract_variable()<CR>",
	["<leader>jc"] = ":lua require('jdtls').extract_constant()<CR>",
	["<leader>jm"] = ":lua require('jdtls').extract_method()<CR>",

	["<leader>xx"] = ":TroubleToggle<CR>",
	["<leader>xw"] = ":TroubleToggle workspace_diagnostics<CR>",
	["<leader>xd"] = ":TroubleToggle document_diagnostics<CR>",
	["<leader>xl"] = ":TroubleToggle lsp_references<CR>",
}

local visual_leader_keymaps = {
	["<leader>ga"] = lua_fn(function()
		require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end),
	["<leader>gr"] = lua_fn(function()
		require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end),
	["<leader>gbl"] = ":lua require('telescope.builtin').git_bcommits_range({ from = vim.fn.line('.'), to = vim.fn.line('v') })<CR>",

	["<leader>jo"] = ":lua require('jdtls').organize_imports()<CR>",
	["<leader>jv"] = ":lua require('jdtls').extract_variable()<CR>",
	["<leader>jc"] = ":lua require('jdtls').extract_constant()<CR>",
	["<leader>jm"] = ":lua require('jdtls').extract_method()<CR>",
}

local normal_keymaps = {
	["<Esc><Esc>"] = ":noh<CR>",

	["<C-w>"] = ":tabclose<CR>",

	["<C-S-Left>"] = "vb",
	["<C-S-Right>"] = "vw",

	["<C-Left>"] = "b",
	["<C-Right>"] = "w",
	["<C-Up>"] = "<C-b>",
	["<C-Down>"] = "<C-f>",

	["<S-Left>"] = "v<Left>",
	["<S-Right>"] = "v<Right>",
	["<S-Up>"] = "v<Up>",
	["<S-Down>"] = "v<Down>",

	["<A-Left>"] = "<C-W><C-H>",
	["<A-Right>"] = "<C-W><C-L>",
	["<A-Up>"] = "<C-W><C-K>",
	["<A-Down>"] = "<C-W><C-J>",

	["xx"] = "dd",
	["d"] = '"_d',
	["dd"] = '"_dd',

	["vv"] = "V",

	["<C-_>"] = ":lua require('Comment.api').toggle.linewise.current()<CR>", -- <C-_> maps to Ctrl+ForwardSlash

	["<Tab>"] = ">>",
	["<S-Tab>"] = "<<",
}

local visual_keymaps = {
	["<Tab>"] = ">gv",
	["<S-Tab>"] = "<gv",

	["<C-Left>"] = "b",
	["<C-Right>"] = "w",

	["<S-Left>"] = "<Left>",
	["<S-Right>"] = "<Right>",
	["<S-Up>"] = "<Up>",
	["<S-Down>"] = "<Down>",

	["xx"] = "d",
	["d"] = '"_d',
	["dd"] = '"_d',

	["p"] = '"_dP',

	["<C-_>"] = ":lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", -- <C-_> maps to Ctrl+ForwardSlash
}

local insert_keymaps = {
	["<C-H>"] = "<C-w>", -- <C-H> maps to Ctrl+Backspace
	["<C-Del>"] = "<C-o>de",

	["<C-z>"] = "<Esc>ui",

	["<C-S-Left>"] = "<Esc>vb",
	["<C-S-Right>"] = "<Esc><Right>vw",

	["<S-Left>"] = "<Esc>v<Left>",
	["<S-Right>"] = "<Esc>v<Right>",
	["<S-Up>"] = "<Esc>v<Up>",
	["<S-Down>"] = "<Esc>v<Down>",

	["<C-_>"] = "<Esc>:lua require('Comment.api').toggle.linewise.current()<CR>i", -- <C-_> maps to Ctrl+ForwardSlash
}

local cmd_keymaps = {
	["<C-H>"] = "<C-w>", -- <C-H> maps to Ctrl+Backspace
}

local cmd_expr_keymaps = {
	["<Up>"] = "wildmenumode() ? '<Left>' : '<Up>'",
	["<Down>"] = "wildmenumode() ? '<Right>' : '<Down>'",
	["<Left>"] = "wildmenumode() ? '<Up>' : '<Left>'",
	["<Right>"] = "wildmenumode() ? '<Down>' : '<Right>'",
}

set_keymaps("n", leader_keymaps, opts)
set_keymaps("v", visual_leader_keymaps, opts)

set_keymaps("n", normal_keymaps, opts)
set_keymaps("v", visual_keymaps, opts)
set_keymaps("i", insert_keymaps, opts)
set_keymaps("c", cmd_keymaps, cmd_opts)
set_keymaps("c", cmd_expr_keymaps, cmd_expr_opts)
