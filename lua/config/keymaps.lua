-- Constants
local LINE_JUMP = 5
local SPLIT_RESIZE = 2
local LEFT_JUMP = "b"
local RIGHT_JUMP = "e"

local utils = require("utils")
local lua_fn = utils.lua_fn
local set_keymaps = utils.set_keymaps

local constants = require("constants")
local opts = constants.OPTS
local expr_opts = constants.EXPR_OPTS
local cmd_opts = constants.CMD_OPTS
local cmd_expr_opts = constants.CMD_EXPR_OPTS

-- Set Space to no-op so it can be remapped to Leader
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", opts)
-- Set Space as Map Leader <leader>
vim.g.mapleader = " "

local leader_keymaps = {
  ["<leader><Esc>"] = { ":noh<CR>:lua vim.lsp.buf.clear_references()<CR>", "Remove Highlights" },

  ["<leader><Left>"] = { "^", "Jump to Start of Line" },
  ["<leader><Right>"] = { "$", "Jump to End of Line" },

  ["<leader>e"] = { ":NvimTreeToggle<CR>", "NvimTree: Toggle" },

  ["<leader>qq"] = { ":qa<CR>", "Quit All" },
  ["<leader>ww"] = { ":lua vim.g.disable_autoformat = true<CR>:w<CR>", "Save without Formatting" },

  ["<leader>ll"] = { ":Lazy<CR>", "Lazy: Open" },

  ["<leader>mm"] = { ":Mason<CR>", "Mason: Open" },

  ["<leader>gp"] = { ":Gitsigns preview_hunk<CR>", "Gitsigns: Preview Hunk" },
  ["<leader>gr"] = { ":Gitsigns reset_hunk<CR>", "Gitsigns: Reset Hunk" },
  ["<leader>gf"] = { ":Telescope git_status<CR>", "Telescope(Git): Open Git Status" },
  ["<leader>gl"] = { ":Telescope git_commits<CR>", "Telescope(Git): Open Git Log" },
  ["<leader>gbl"] = { ":Telescope git_bcommits<CR>", "Telescope(Git): Open Git Log for Current Buffer" },
  ["<leader>gg"] = {
    ":9TermExec cmd='lazygit && exit' direction=float name='lazygit'<CR>",
    "Terminal(Git): Open LazyGit",
  },

  ["<leader>cq"] = { ":GitConflictListQf<CR>", "GitConflict: Send Conflicts to QuickFix List" },
  ["<leader>c<Up>"] = { ":GitConflictPrevConflict<CR>", "GitConflict: Jump to Previous Conflict" },
  ["<leader>c<Down>"] = { ":GitConflictNextConflict<CR>", "GitConflict: Jump to Next Conflict" },

  ["<leader>ff"] = { ":Telescope find_files<CR>", "Telescope: Find Files in Project" },
  ["<leader>fg"] = { ":Telescope live_grep<CR>", "Telescope: Grep in Project" },
  ["<leader>fG"] = { ":Telescope live_grep type_filter=", "Telescope: Grep in Project in Specific Filetypes" },
  ["<leader>fk"] = { ":Telescope keymaps<CR>", "Telescope: Keymaps" },
  ["<leader>fh"] = { ":Telescope help_tags<CR>", "Telescope: Help Tags" },
  ["<leader>fb"] = { ":Telescope buffers<CR>", "Telescope: List Buffers" },

  ["<leader>tt"] = { ":TermSelect<CR>", "Terminal: Select from Open Terminals" },
  ["<leader>t1"] = { ":1ToggleTerm direction=float<CR>", "Terminal: Open Terminal 1 (Floating)" },
  ["<leader>t2"] = { ":2ToggleTerm direction=float<CR>", "Terminal: Open Terminal 2 (Floating)" },
  ["<leader>t3"] = { ":3ToggleTerm direction=float<CR>", "Terminal: Open Terminal 3 (Floating)" },

  ["<leader>fr"] = {
    ":lua require('marksman').runCmdAndMark('Telescope lsp_references', true, false)<CR>",
    "Telescope: List LSP References",
  },
  ["<leader>fi"] = {
    ":lua require('marksman').runCmdAndMark('Telescope lsp_implementations', true, false)<CR>",
    "Telescope: List LSP Implementations",
  },
  ["<leader>fd"] = {
    ":lua require('marksman').runCmdAndMark('Telescope lsp_definitions', true, false)<CR>",
    "Telescope: List LSP Definitions",
  },
  ["<leader>fs"] = { ":Telescope lsp_document_symbols<CR>", "Telescope: List LSP Document Symbols" },
  ["<leader>fw"] = { ":Telescope lsp_dynamic_workspace_symbols<CR>", "Telescope: List LSP Workspace Symbols" },
  ["<leader>ft"] = { ":TodoTelescope<CR>", "Telescope: List Todo Comments" },

  ["<leader>xx"] = { ":Trouble diagnostics toggle<CR>", "Trouble: Toggle Diagnostics" },
  ["<leader>xb"] = { ":Trouble diagnostics toggle filter.buf=0<CR>", "Trouble: Toggle Diagnostics for Buffer" },
  ["<leader>xs"] = { ":Trouble symbols toggle<CR>", "Trouble: Toggle Symbols" },

  ["<leader>rr"] = {
    ":lua require('telescope').extensions.refactoring.refactors()<CR>",
    "Refactoring: List Refactoring Actions",
  },

  ["<leader>sd"] = { ":SessionDelete<CR>", "AutoSession: Delete Session" },

  ["<leader>uu"] = { ":UndotreeToggle<CR>", "Undotree: Toggle Undotree" },

  ["<leader>zz"] = { ":ZenMode<CR>", "ZenMode: Toggle Mode" },

  ["<leader>bb"] = { ":BloatInit<CR>", "Bloat: Initialize Buffers" },
}

local visual_leader_keymaps = {
  ["<leader>gr"] = { ":Gitsigns reset_hunk vim.fn.line('.') vim.fn.line('v')<CR>", "Gitsigns: Reset Selected Hunk" },
  ["<leader>gbl"] = {
    ":lua require('telescope.builtin').git_bcommits_range({ from = vim.fn.line('.'), to = vim.fn.line('v') })<CR>",
    "Gitsigns: Open Git Log for Selected Range",
  },

  ["<leader>jo"] = {
    ":lua require('jdtls').organize_imports()<CR>",
    "JDTLS(Java): Organize Imports in Selected Code",
  },

  ["<leader>rr"] = {
    ":lua require('telescope').extensions.refactoring.refactors()<CR>",
    "Refactoring: List Refactoring Actions for Selected Code",
  },

  ["<leader>fg"] = {
    lua_fn(function()
      require("telescope.builtin").live_grep({ default_text = utils.get_visual_selection() })
    end),
    "Telescope: Grep Selected Text in Project",
  },

  ["<leader><Left>"] = { "^", "Jump to Start of Line" },
  ["<leader><Right>"] = { "$", "Jump to End of Line" },
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

  ["d"] = { '"_d', "Delete Text without Copy" },
  ["<Del>"] = { '"_d<Right>', "Delete Text without Copy" },

  ["dp"] = { '""p', 'Paste Deleted ("") Content' },

  ["dd"] = { '""dd', "Delete Lines without Copy" },
  ["dw"] = { '""dw', "Delete Lines without Copy" },
  ["di"] = { '""di', "Delete Lines without Copy" },
  ["da"] = { '""da', "Delete Lines without Copy" },
  ["dt"] = { '""dt', "Delete Till without Copy" },
  ["df"] = { '""df', "Delete Till (Inclusive) without Copy" },
  ["dT"] = { '""dT', "Delete Back Till without Copy" },
  ["dF"] = { '""dF', "Delete Back Till (Inclusive) without Copy" },

  ["daf"] = { ':TSTextobjectSelect @function.outer<CR>""x', "" },
  ["dif"] = { ':TSTextobjectSelect @function.inner<CR>""x', "" },
  ["dac"] = { ':TSTextobjectSelect @class.outer<CR>""x', "" },
  ["dic"] = { ':TSTextobjectSelect @class.inner<CR>""x', "" },
  ["das"] = { ':TSTextobjectSelect @block.outer<CR>""x', "" },
  ["dis"] = { ':TSTextobjectSelect @block.inner<CR>""x', "" },
  ["dap"] = { ':TSTextobjectSelect @parameter.outer<CR>""x', "" },
  ["dip"] = { ':TSTextobjectSelect @parameter.inner<CR>""x', "" },

  ["cc"] = { '""cc', "Change Lines without Copy" },
  ["cw"] = { '""cw', "Change Word without Copy" },
  ["ci"] = { '""ci', "Change In without Copy" },
  ["ca"] = { '""ca', "Change Around without Copy" },
  ["ct"] = { '""ct', "Change Till without Copy" },
  ["cf"] = { '""cf', "Change Till (Inclusive) without Copy" },
  ["cT"] = { '""cT', "Change Back Till without Copy" },
  ["cF"] = { '""cF', "Change Back Till (Inclusive) without Copy" },

  ["<C-/>"] = { ":lua require('Comment.api').toggle.linewise.current()<CR>", "Comment Current Line" },

  --[[ ["<C-F>"] = { ":MarksmanPrev<CR>", "Marksman: Jump to Previous Mark" },
  ["<C-G>"] = { ":MarksmanNext<CR>", "Marksman: Jump to Next Mark" },
  ["<C-M>"] = { ":MarksmanAdd<CR>", "Marksman: Add to Marks List" },
  ["<C-S-M>"] = { ":MarksmanRemoveTop<CR>", "Marksman: Add to Marks List" }, ]]

  ["<Tab>"] = { ">>", "Indent Current Line to Right" },
  ["<S-Tab>"] = { "<<", "Indent Current Line to Left" },

  ["<A-S-Up>"] = { ":m .-2<CR>==", "Move Current Line Up" },
  ["<A-S-Down>"] = { ":m .+1<CR>==", "Move Current Line Down" },

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

local normal_expr_keymaps = {
  ["<Down>"] = { "v:count ? 'j' : 'gj'", "Navigate Down in Wrapped Lines" },
  ["<Up>"] = { "v:count ? 'k' : 'gk'", "Navigate Up in Wrapped Lines" },
}

local visual_keymaps = {
  ["<Tab>"] = { ">gv", "Indent Selected Code to Right" },
  ["<S-Tab>"] = { "<gv", "Indent Selected Code to Left" },

  ["<C-Left>"] = { LEFT_JUMP, "Jump Left by Word" },
  ["<C-Right>"] = { RIGHT_JUMP, "Jump Right by Word" },
  ["<C-Up>"] = { LINE_JUMP .. "k", "Jump " .. LINE_JUMP .. " Lines Up" },
  ["<C-Down>"] = { LINE_JUMP .. "j", "Jump " .. LINE_JUMP .. " Lines Down" },

  ["<Del>"] = { '"_d', "Delete Selected Text without Copy" },

  ["D"] = { '""D', "Delete Selected Text without Copy" },
  ["dd"] = { '""x', "Delete Selected Text without Copy" },

  ["C"] = { '""C', "Change Selected Text without Copy" },
  ["c"] = { '""c', "Change In Selected Text without Copy" },

  ["p"] = { '"_dP', "Paste without Copy on Selected Text" },

  ["<C-/>"] = {
    ":lua require('Comment.api').toggle.blockwise(vim.fn.visualmode(), { ignore = '^$', padding = true })<CR>",
    "Comment Selected Lines",
  },

  ["<A-S-Up>"] = { ":m '<-2<CR><CR>gv=gv", "Move Selected Line Up" },
  ["<A-S-Down>"] = { ":m '>+1<CR><CR>gv=gv", "Move Selected Line Down" },

  ["<C-R>"] = { '"hy<Esc>:%s/<C-r>h//gc<Left><Left><Left>', "" },
}

local insert_keymaps = {
  ["<C-C>"] = { "<C-w>", "Delete Word by Left" },

  ["<C-Up>"] = { "<Esc>" .. LINE_JUMP .. "ki", "Jump " .. LINE_JUMP .. " Lines Up" },
  ["<C-Down>"] = { "<Esc>" .. LINE_JUMP .. "ji", "Jump " .. LINE_JUMP .. " Lines Down" },

  ["<C-/>"] = { "<Esc>:lua require('Comment.api').toggle.linewise.current()<CR>i", "Comment Current Line" },

  ["<A-S-Up>"] = { "<Esc>:m .-2<CR>==gi", "Move Current Line Up" },
  ["<A-S-Down>"] = { "<Esc>:m .+1<CR>==gi", "Move Current Line Down" },
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

local term_keymaps = {
  [ [[<C-\>]] ] = { [[<C-\><C-n>]], "Terminal: Enter Normal Mode" },
}

set_keymaps("n", leader_keymaps, opts)
set_keymaps("v", visual_leader_keymaps, opts)

set_keymaps("n", normal_keymaps, opts)
set_keymaps("n", normal_expr_keymaps, expr_opts)
set_keymaps("v", visual_keymaps, opts)
set_keymaps("i", insert_keymaps, opts)
set_keymaps("c", cmd_keymaps, cmd_opts)
set_keymaps("c", cmd_expr_keymaps, cmd_expr_opts)
set_keymaps("t", term_keymaps, opts)
