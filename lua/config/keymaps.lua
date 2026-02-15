-- Constants
local LINE_JUMP = 5
local SPLIT_RESIZE = 2
local LEFT_JUMP = "b"
local RIGHT_JUMP = "e"

local utils = require("utils")
local set_keymaps = utils.set_keymaps

local constants = require("constants")
local opts = constants.OPTS
local nowait_opts = constants.NOWAIT_OPTS
local expr_opts = constants.EXPR_OPTS
local cmd_opts = constants.CMD_OPTS

-- Set Space to no-op so it can be remapped to Leader
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", opts)
-- Set Space as Map Leader <leader>
vim.g.mapleader = " "

local leader_keymaps = {
  ["<leader><Esc>"] = { ":noh<CR>:lua vim.lsp.buf.clear_references()<CR>", "Remove Highlights" },

  ["<leader><Left>"] = { "g^", "Jump to Start of Line" },
  ["<leader><Right>"] = { "g$", "Jump to End of Line" },

  ["<leader>e"] = { ":NvimTreeToggle<CR>", "NvimTree: Toggle" },

  ["<leader>qq"] = {
    ":lua local b = vim.fn.bufnr('kulala://ui'); if b ~= -1 then vim.api.nvim_buf_delete(b, { force=true }) end; vim.cmd('qa')<CR>",
    "Quit All",
  },
  ["<leader>ww"] = { ":lua vim.g.disable_autoformat = true<CR>:w<CR>", "Save without Formatting" },

  ["<leader>ll"] = { ":Lazy<CR>", "Lazy: Open" },

  ["<leader>mm"] = { ":Mason<CR>", "Mason: Open" },

  ["<leader>gp"] = { ":Gitsigns preview_hunk<CR>", "Gitsigns: Preview Hunk" },
  ["<leader>gr"] = { ":Gitsigns reset_hunk<CR>", "Gitsigns: Reset Hunk" },
  ["<leader>gg"] = {
    ":9TermExec cmd='lazygit && exit' direction=float name='lazygit'<CR>",
    "Terminal(Git): Open LazyGit",
  },

  ["<leader>cq"] = { ":GitConflictListQf<CR>", "GitConflict: Send Conflicts to QuickFix List" },
  ["<leader>c<Up>"] = { ":GitConflictPrevConflict<CR>", "GitConflict: Jump to Previous Conflict" },
  ["<leader>c<Down>"] = { ":GitConflictNextConflict<CR>", "GitConflict: Jump to Next Conflict" },

  ["<leader>tt"] = { ":TermSelect<CR>", "Terminal: Select from Open Terminals" },
  ["<leader>t1"] = { ":1ToggleTerm direction=float<CR>", "Terminal: Open Terminal 1 (Floating)" },
  ["<leader>t2"] = { ":2ToggleTerm direction=float<CR>", "Terminal: Open Terminal 2 (Floating)" },
  ["<leader>t3"] = { ":3ToggleTerm direction=float<CR>", "Terminal: Open Terminal 3 (Floating)" },

  ["<leader>xx"] = { ":Trouble diagnostics toggle<CR>", "Trouble: Toggle Diagnostics" },
  ["<leader>xb"] = { ":Trouble diagnostics toggle filter.buf=0<CR>", "Trouble: Toggle Diagnostics for Buffer" },
  ["<leader>xs"] = { ":Trouble symbols toggle<CR>", "Trouble: Toggle Symbols" },

  ["<leader>sd"] = { ":AutoSession delete<CR>", "AutoSession: Delete Session" },

  ["<leader>uu"] = { ":UndotreeToggle<CR>", "Undotree: Toggle Undotree" },

  ["<leader>zz"] = { ":ZenMode<CR>", "ZenMode: Toggle Mode" },

  ["<leader>bb"] = { ":BloatInit<CR>", "Bloat: Initialize Buffers" },
}

local visual_leader_keymaps = {
  ["<leader>gr"] = { ":Gitsigns reset_hunk vim.fn.line('.') vim.fn.line('v')<CR>", "Gitsigns: Reset Selected Hunk" },

  ["<leader>jo"] = {
    ":lua require('jdtls').organize_imports()<CR>",
    "JDTLS(Java): Organize Imports in Selected Code",
  },

  ["<leader><Left>"] = { "g^", "Jump to Start of Line" },
  ["<leader><Right>"] = { "g$", "Jump to End of Line" },
}

local normal_keymaps = {
  ["<C-Left>"] = { LEFT_JUMP, "Jump Left by Word" },
  ["<C-Right>"] = { RIGHT_JUMP, "Jump Right by Word" },
  ["<C-Up>"] = { LINE_JUMP .. "k", "Jump " .. LINE_JUMP .. " Lines Up" },
  ["<C-Down>"] = { LINE_JUMP .. "j", "Jump " .. LINE_JUMP .. " Lines Down" },

  ["<A-Left>"] = { "<C-W><C-H>", "Jump to Left Buffer" },
  ["<A-Right>"] = { "<C-W><C-L>", "Jump to Right Buffer" },
  ["<A-Up>"] = { "<C-W><C-K>", "Jump to Up Buffer" },
  ["<A-Down>"] = { "<C-W><C-J>", "Jump to Down Buffer" },

  ["y"] = { '"+y', "Copy Text to System Clipboard" },
  ["Y"] = { '"+y$', "Copy Text to System Clipboard" },

  ["x"] = { '"+x', "Delete and Copy Text to System Clipboard" },

  ["dp"] = { '""p', "Paste Deleted Text from Quote Register" },
  ["p"] = { '"+p', "Paste Text from System Clipboard" },
  ["dP"] = { '""P', "Paste Deleted Text from Quote Register Before Cursor" },
  ["P"] = { '"+P', "Paste Deleted Text from System Clipboard Before Cursor" },

  ["<C-/>"] = { ":lua require('Comment.api').toggle.linewise.current()<CR>", "Comment Current Line" },

  [">"] = { ">>", "Indent Current Line to Right" },
  ["<"] = { "<<", "Indent Current Line to Left" },

  ["<S-Up>"] = { ":m .-2<CR>==", "Move Current Line Up" },
  ["<S-Down>"] = { ":m .+1<CR>==", "Move Current Line Down" },

  ["<C-S-Left>"] = { ":vertical resize -" .. SPLIT_RESIZE .. "<CR>", "Decrease Split Width by " .. SPLIT_RESIZE },
  ["<C-S-Right>"] = { ":vertical resize +" .. SPLIT_RESIZE .. "<CR>", "Increase Split Width by " .. SPLIT_RESIZE },
  ["<C-S-Down>"] = { ":resize -" .. SPLIT_RESIZE .. "<CR>", "Decrease Split Height by " .. SPLIT_RESIZE },
  ["<C-S-Up>"] = { ":resize +" .. SPLIT_RESIZE .. "<CR>", "Increase Split Height by " .. SPLIT_RESIZE },

  ["<A-w>"] = { ":FocusFloating<CR>", "Focus Floating Window" },

  ["gb"] = { "<C-^>", "Jump to Alternate Buffer" },
  ["gf"] = { ":GotoLine<CR>", "Goto Line and Column" },

  ["<F1>"] = { "<Nop>", "Disable Help" },

  ["M"] = { "%", "Jump to Bracket Pair" },

  ["<C-b>"] = { ":BloatCreate<CR>", "Bloat: Create Scratch Buffer" },
  ["<C-t>"] = { ":BloatToggle<CR>", "Bloat: Toggle Floating Buffer" },
}

local normal_nowait_keymaps = {
  ["gr"] = { ":AltTab<CR>", "Disable Wait for `gr`" },
}

local normal_expr_keymaps = {
  ["<Down>"] = { "v:count ? 'j' : 'gj'", "Navigate Down in Wrapped Lines" },
  ["<Up>"] = { "v:count ? 'k' : 'gk'", "Navigate Up in Wrapped Lines" },
}

local visual_keymaps = {
  [">"] = { ">gv", "Indent Selected Code to Right" },
  ["<"] = { "<gv", "Indent Selected Code to Left" },

  ["<C-Left>"] = { LEFT_JUMP, "Jump Left by Word" },
  ["<C-Right>"] = { RIGHT_JUMP, "Jump Right by Word" },
  ["<C-Up>"] = { LINE_JUMP .. "k", "Jump " .. LINE_JUMP .. " Lines Up" },
  ["<C-Down>"] = { LINE_JUMP .. "j", "Jump " .. LINE_JUMP .. " Lines Down" },

  ["y"] = { '"+y', "Copy Text to System Clipboard" },

  ["dd"] = { "x", "Delete and Copy Text to System Clipboard" },
  ["x"] = { '"+x', "Delete and Copy Text to System Clipboard" },

  ["dp"] = { '""p', "Paste Deleted Text from Quote Register" },
  ["p"] = { '"+p', "Paste Deleted Text from Quote Register Before Cursor" },

  ["<C-/>"] = {
    ":lua require('Comment.api').toggle.blockwise(vim.fn.visualmode(), { ignore = '^$', padding = true })<CR>",
    "Comment Selected Lines",
  },

  ["<S-Up>"] = { ":m '<-2<CR><CR>gv=gv", "Move Selected Line Up" },
  ["<S-Down>"] = { ":m '>+1<CR><CR>gv=gv", "Move Selected Line Down" },

  ["<C-R>"] = { '"hy<Esc>:%s/<C-r>h//gc<Left><Left><Left>', "" },
}

local insert_keymaps = {
  ["<C-C>"] = { "<C-w>", "Delete Word by Left" },

  ["<C-Up>"] = { "<Esc>" .. LINE_JUMP .. "ki", "Jump " .. LINE_JUMP .. " Lines Up" },
  ["<C-Down>"] = { "<Esc>" .. LINE_JUMP .. "ji", "Jump " .. LINE_JUMP .. " Lines Down" },

  ["<C-/>"] = { "<Esc>:lua require('Comment.api').toggle.linewise.current()<CR>i", "Comment Current Line" },

  ["<S-Up>"] = { "<Esc>:m .-2<CR>==gi", "Move Current Line Up" },
  ["<S-Down>"] = { "<Esc>:m .+1<CR>==gi", "Move Current Line Down" },
}

local cmd_keymaps = {
  ["<C-H>"] = { "<C-w>", "Delete Word by Left" }, -- <C-H> maps to Ctrl+Backspace
}

local term_keymaps = {
  [ [[<C-\>]] ] = { [[<C-\><C-n>]], "Terminal: Enter Normal Mode" },
}

set_keymaps("n", leader_keymaps, opts)
set_keymaps("v", visual_leader_keymaps, opts)

set_keymaps("n", normal_keymaps, opts)
set_keymaps("n", normal_nowait_keymaps, nowait_opts)
set_keymaps("n", normal_expr_keymaps, expr_opts)
set_keymaps("v", visual_keymaps, opts)
set_keymaps("i", insert_keymaps, opts)
set_keymaps("c", cmd_keymaps, cmd_opts)
set_keymaps("t", term_keymaps, opts)
