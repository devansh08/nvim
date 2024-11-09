local set_keymaps = require("utils").set_keymaps

local cmd_opts = require("constants").CMD_OPTS

local keymaps = {
  ["<CR>"] = { ":.cc<CR>", "Quickfix: Open Current Entry" },
}

set_keymaps("n", keymaps, cmd_opts, true)
