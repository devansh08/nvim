-- 'silent' prevents any output messages
local opts = { noremap = true, silent = true }

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
}

local normal_keymaps = {
  ["<Esc><Esc>"] = ":noh<CR>",

  ["<C-w>"] = ":tabclose<CR>",
}

local visual_keymaps = {
  [">"] = ">gv",
  ["<"] = "<gv",
}

set_keymaps("n", leader_keymaps, opts)

set_keymaps("n", normal_keymaps, opts)
set_keymaps("n", visual_keymaps, opts)

