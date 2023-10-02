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
  ["<leader>e"] = ":Lexplore 20<CR>",

  ["<leader>qq"] = ":qa<CR>",

  ["<leader>ll"] = ":Lazy<CR>",
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
}

local visual_keymaps = {
  [">"] = ">gv",
  ["<"] = "<gv",

  ["<C-Left>"] = "b",
  ["<C-Right>"] = "w",

  ["<S-Left>"] = "<Left>",
  ["<S-Right>"] = "<Right>",
  ["<S-Up>"] = "<Up>",
  ["<S-Down>"] = "<Down>",

  ["xx"] = "dd",
  ["d"] = '"_d',
  ["dd"] = '"_dd',

  ["p"] = '"_dP',
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

set_keymaps("n", normal_keymaps, opts)
set_keymaps("v", visual_keymaps, opts)
set_keymaps("i", insert_keymaps, opts)
set_keymaps("c", cmd_keymaps, cmd_opts)
set_keymaps("c", cmd_expr_keymaps, cmd_expr_opts)

