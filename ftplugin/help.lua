local set_keymaps = require("utils").set_keymaps

local cmd_opts = require("constants").CMD_OPTS

local keymaps = {
  ["<CR>"] = { "<C-]>", "Help: Jump Forward to Tag under Cursor" },
  ["<BS>"] = { "<C-T>", "Help: Jump Back to Previous Tag" },
}

set_keymaps("n", keymaps, cmd_opts, true)
