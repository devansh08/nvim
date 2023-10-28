-- Constants
local LINE_JUMP = 5
local LEFT_JUMP = "b"
local RIGHT_JUMP = "e"

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
		keymap_opts["desc"] = v[2]
		vim.api.nvim_set_keymap(mode, k, v[1], keymap_opts)
	end
end

-- Set Space to no-op so it can be remapped to Leader
keymap("", "<Space>", "<Nop>", opts)
-- Set Space as Map Leader <leader>
vim.g.mapleader = " "

local leader_keymaps = {
	["<leader>e"] = { ":NvimTreeToggle<CR>", "NvimTree: Toggle" },

	["<leader>qq"] = { ":qa<CR>", "Quit All" },
	["<leader>ww"] = { ":lua vim.g.no_format = true<CR>:w<CR>", "Save without Formatting" },

	["<leader>ll"] = { ":Lazy<CR>", "Lazy: Open" },

	["<leader>mm"] = { ":Mason<CR>", "Mason: Open" },

	["<leader>gs"] = { ":Git<CR>", "Fugitive(Git): Open Status" },
	["<leader>gc"] = { ":Git commit<CR>", "Fugitive(Git): Commit changes" },
	["<leader>gd"] = { ":Git diff<CR>", "Fugitive(Git): Open Diff" },
	["<leader>gds"] = { ":Git diff --staged<CR>", "Fugitive(Git): Open Staged Diff" },
	["<leader>gpl"] = { ":Git pull<CR>", "Fugitive(Git): Pull" },
	["<leader>gph"] = {
		":lua if vim.fn.input('Push changes ? ') == 'y' then vim.cmd(':redraw'); vim.cmd(':Git push') else vim.cmd(':redraw'); print('Push aborted') end<CR>",
		"Fugitive(Git): Push with confirmation",
	},
	["<leader>gp"] = { ":lua require('gitsigns').preview_hunk()<CR>", "Gitsigns: Preview Hunk" },
	["<leader>gA"] = { ":lua require('gitsigns').stage_buffer()<CR>", "Gitsigns: Stage entire Buffer" },
	["<leader>ga"] = { ":lua require('gitsigns').stage_hunk()<CR>", "Gitsigns: Stage Hunk" },
	["<leader>gr"] = { ":lua require('gitsigns').reset_hunk()<CR>", "Gitsigns: Reset Hunk" },
	["<leader>gu"] = { ":lua require('gitsigns').undo_stage_hunk()<cr>", "Gitsigns: Undo Stage Hunk" },
	["<leader>g<Down>"] = {
		":lua require('gitsigns').next_hunk({ wrap = false, navigation_message = false, preview = false })<cr>",
		"Gitsigns: Jump to Next Hunk",
	},
	["<leader>g<Up>"] = {
		":lua require('gitsigns').prev_hunk({ wrap = false, navigation_message = false, preview = false })<CR>",
		"Gitsigns: Jump to Previous Hunk",
	},
	["<leader>gl"] = { ":Telescope git_commits<CR>", "Telescope(Git): Open Git Log" },
	["<leader>gbl"] = { ":Telescope git_bcommits<CR>", "Telescope(Git): Open Git Log for Current Buffer" },
	["<leader>gsl"] = { ":Telescope git_stash<CR>", "Telescope(Git): Open Git Stash List" },
	["<leader>gg"] = {
		":9TermExec cmd='lazygit && exit' direction=float name='lazygit'<CR>",
		"Terminal(Git): Open LazyGit",
	},

	["<leader>ff"] = { ":Telescope find_files<CR>", "Telescope: Find Files in Project" },
	["<leader>fg"] = { ":Telescope live_grep<CR>", "Telescope: Grep in Project" },
	["<leader>fk"] = { ":Telescope keymaps<CR>", "Telescope: Keymaps" },
	["<leader>fj"] = { ":Telescope jumplist<CR>", "Telescope: Jumplist" },
	["<leader>fb"] = { ":Telescope buffers<CR>", "Telescope: List Buffers" },

	["<leader>tt"] = { ":TermSelect<CR>", "Terminal: Select from Open Terminals" },
	["<leader>t1"] = { ":1ToggleTerm direction=float<CR>", "Terminal: Open Terminal 1 (Floating)" },
	["<leader>t2"] = { ":2ToggleTerm direction=float<CR>", "Terminal: Open Terminal 2 (Floating)" },
	["<leader>t3"] = { ":3ToggleTerm direction=float<CR>", "Terminal: Open Terminal 3 (Floating)" },
	["<leader>th"] = { ":4ToggleTerm direction=horizontal<CR>", "Terminal: Open Terminal 4 (Horizontal)" },

	["<leader>fr"] = { ":Telescope lsp_references<CR>", "Telescope: List LSP References" },
	["<leader>fi"] = { ":Telescope lsp_implementations<CR>", "Telescope: List LSP Implementations" },
	["<leader>fd"] = { ":Telescope lsp_definitions<CR>", "Telescope: List LSP Definitions" },
	["<leader>fe"] = { ":Telescope diagnostics<CR>", "Telescope: List Diagnostics in Project" },
	["<leader>fc"] = {
		":lua require('telescope.builtin').diagnostics({ bufnr = 0 })<CR>",
		"Telescope: List Diagnostics in Current Buffer",
	},

	["<leader>jo"] = { ":lua require('jdtls').organize_imports()<CR>", "JDTLS(Java): Organize Imports" },
	["<leader>jv"] = { ":lua require('jdtls').extract_variable()<CR>", "JDTLS(Java): Extract to Variable" },
	["<leader>jc"] = { ":lua require('jdtls').extract_constant()<CR>", "JDTLS(Java): Extract to Constant" },
	["<leader>jm"] = { ":lua require('jdtls').extract_method()<CR>", "JDTLS(Java): Extract to Method/Function" },

	["<leader>xx"] = { ":TroubleToggle<CR>", "Trouble: Toggle Trouble Buffer" },
	["<leader>xw"] = { ":TroubleToggle workspace_diagnostics<CR>", "Trouble: List Project Diagnostics" },
	["<leader>xd"] = { ":TroubleToggle document_diagnostics<CR>", "Trouble: List Buffer Diagnostics" },
	["<leader>xr"] = { ":TroubleToggle lsp_references<CR>", "Trouble: List LSP References" },
	["<leader>xl"] = { ":TroubleToggle lsp_definitions<CR>", "Trouble: List LSP Definitions" },
	["<leader>xt"] = { ":TroubleToggle lsp_type_definitions<CR>", "Trouble: List LSP Type Definitions" },

	["<leader>rr"] = {
		":lua require('telescope').extensions.refactoring.refactors()<CR>",
		"Refactoring: List Refactoring Actions",
	},
	["<leader>ri"] = { ":Refactor inline_var<CR>", "Refactoring: Extract to Inline Variable" },
	["<leader>rif"] = { ":Refactor inline_func<CR>", "Refactoring: Extract to Inline Function" },
	["<leader>rb"] = { ":Refactor extract_block<CR>", "Refactoring: Extract Code Block" },
	["<leader>rbf"] = { ":Refactor extract_block_to_file<CR>", "Refactoring: Extract Code Block to File" },
}

local visual_leader_keymaps = {
	["<leader>ga"] = {
		lua_fn(function()
			require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end),
		"Gitsigns: Stage Selected Hunk",
	},
	["<leader>gr"] = {
		lua_fn(function()
			require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end),
		"Gitsigns: Reset Selected Hunk",
	},
	["<leader>gbl"] = {
		":lua require('telescope.builtin').git_bcommits_range({ from = vim.fn.line('.'), to = vim.fn.line('v') })<CR>",
		"Gitsigns: Open Git Log for Selected Range",
	},

	["<leader>jo"] = {
		":lua require('jdtls').organize_imports()<CR>",
		"JDTLS(Java): Organize Imports in Selected Code",
	},
	["<leader>jv"] = {
		":lua require('jdtls').extract_variable()<CR>",
		"JDTLS(Java): Extract Selected Code to Variable",
	},
	["<leader>jc"] = {
		":lua require('jdtls').extract_constant()<CR>",
		"JDTLS(Java): Extract Selected Code to Constant",
	},
	["<leader>jm"] = {
		":lua require('jdtls').extract_method()<CR>",
		"JDTLS(Java): Extract Selected Code to Method/Function",
	},

	["<leader>rr"] = {
		":lua require('telescope').extensions.refactoring.refactors()<CR>",
		"Refactoring: List Refactoring Actions for Selected Code",
	},
	["<leader>re"] = { ":Refactor extract<CR>", "Refactoring: Extract Selected Code" },
	["<leader>rf"] = { ":Refactor extract_to_file<CR>", "Refactoring: Extract Selected Code to File" },
	["<leader>rv"] = { ":Refactor extract_var<CR>", "Refactoring: Extract Selected Code to Variable" },
	["<leader>ri"] = { ":Refactor inline_var<CR>", "Refactoring: Extract Selected Code to Inline Variable" },
}

local normal_keymaps = {
	["<Esc><Esc>"] = { ":noh<CR>", "Remove Highlights" },

	["<C-w>"] = { ":tabclose<CR>", "Close Tab/Buffer" },

	["<C-S-Left>"] = { "v" .. LEFT_JUMP, "Select Left by Word" },
	["<C-S-Right>"] = { "v" .. RIGHT_JUMP, "Select Right by Word" },

	["<C-Left>"] = { LEFT_JUMP, "Jump Left by Word" },
	["<C-Right>"] = { RIGHT_JUMP, "Jump Right by Word" },
	["<C-Up>"] = { LINE_JUMP .. "k", "Jump " .. LINE_JUMP .. " Lines Up" },
	["<C-Down>"] = { LINE_JUMP .. "j", "Jump " .. LINE_JUMP .. " Lines Down" },

	["<S-Left>"] = { "v<Left>", "Select Left" },
	["<S-Right>"] = { "v<Right>", "Select Right" },
	["<S-Up>"] = { "v<Up>", "Select Up" },
	["<S-Down>"] = { "v<Down>", "Select Down" },

	["<A-Left>"] = { "<C-W><C-H>", "Jump to Left Buffer" },
	["<A-Right>"] = { "<C-W><C-L>", "Jump to Right Buffer" },
	["<A-Up>"] = { "<C-W><C-K>", "Jump to Up Buffer" },
	["<A-Down>"] = { "<C-W><C-J>", "Jump to Down Buffer" },

	["xx"] = { "dd", "Delete Lines and Copy" },
	["d"] = { '"_d', "Delete Character without Copy" },
	["dd"] = { '"_dd', "Delete Lines without Copy" },

	["vv"] = { "V", "Select Current Line" },

	["<C-_>"] = { ":lua require('Comment.api').toggle.linewise.current()<CR>", "Comment Current Line" }, -- <C-_> maps to Ctrl+ForwardSlash

	["gx"] = { ":silent execute '!$BROWSER ' . shellescape(expand('<cfile>'), 1)<CR>", "Open Link in Browser" },

	["<Tab>"] = { ">>", "Indent Current Line to Right" },
	["<S-Tab>"] = { "<<", "Indent Current Line to Left" },
}

local visual_keymaps = {
	["<Tab>"] = { ">gv", "Indent Selected Code to Right" },
	["<S-Tab>"] = { "<gv", "Indent Selected Code to Left" },

	["<C-Left>"] = { LEFT_JUMP, "Jump Left by Word" },
	["<C-Right>"] = { RIGHT_JUMP, "Jump Right by Word" },
	["<C-Up>"] = { LINE_JUMP .. "k", "Jump " .. LINE_JUMP .. " Lines Up" },
	["<C-Down>"] = { LINE_JUMP .. "j", "Jump " .. LINE_JUMP .. " Lines Down" },

	["xx"] = { "d", "Delete Selected Lines and Copy" },
	["d"] = { '"_d', "Delete Selected Text without Copy" },
	["dd"] = { '"_d', "Delete Selected Lines without Copy" },
	["<Del>"] = { '"_d', "Delete Selected Text without Copy" },

	["p"] = { '"_dP', "Paste without Copy on Selected Text" },

	["<C-_>"] = { ":lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", "Comment Selected Lines" }, -- <C-_> maps to Ctrl+ForwardSlash
}

local insert_keymaps = {
	["<C-H>"] = { "<C-w>", "Delete Word by Left" }, -- <C-H> maps to Ctrl+Backspace
	["<C-Del>"] = { "<C-o>de", "Delete Word by Right" },

	["<C-z>"] = { "<Esc>ui", "Undo Changes" },

	["<C-Up>"] = { "<Esc>" .. LINE_JUMP .. "ki", "Jump " .. LINE_JUMP .. " Lines Up" },
	["<C-Down>"] = { "<Esc>" .. LINE_JUMP .. "ji", "Jump " .. LINE_JUMP .. " Lines Down" },

	["<C-S-Left>"] = { "<Esc>v" .. LEFT_JUMP, "Select Left by Word" },
	["<C-S-Right>"] = { "<Esc><Right>v" .. RIGHT_JUMP, "Select Right by Word" },

	["<S-Left>"] = { "<Esc>v<Left>", "Select Left" },
	["<S-Right>"] = { "<Esc>v<Right>", "Select Right" },
	["<S-Up>"] = { "<Esc>v<Up>", "Select Up" },
	["<S-Down>"] = { "<Esc>v<Down>", "Select Down" },

	["<C-_>"] = { "<Esc>:lua require('Comment.api').toggle.linewise.current()<CR>i", "Comment Current Line" }, -- <C-_> maps to Ctrl+ForwardSlash
}

local cmd_keymaps = {
	["<C-H>"] = { "<C-w>", "Delete Word by Left" }, -- <C-H> maps to Ctrl+Backspace
}

local cmd_expr_keymaps = {
	["<Up>"] = { "wildmenumode() ? '<Left>' : '<Up>'", "" },
	["<Down>"] = { "wildmenumode() ? '<Right>' : '<Down>'", "" },
	["<Left>"] = { "wildmenumode() ? '<Up>' : '<Left>'", "" },
	["<Right>"] = { "wildmenumode() ? '<Down>' : '<Right>'", "" },
}

set_keymaps("n", leader_keymaps, opts)
set_keymaps("v", visual_leader_keymaps, opts)

set_keymaps("n", normal_keymaps, opts)
set_keymaps("v", visual_keymaps, opts)
set_keymaps("i", insert_keymaps, opts)
set_keymaps("c", cmd_keymaps, cmd_opts)
set_keymaps("c", cmd_expr_keymaps, cmd_expr_opts)
