local M = {}

M.HOME = os.getenv("HOME")

M.NVIM_CONFIG = M.HOME .. "/.config/nvim"

M.NVIM_LOCAL = M.HOME .. "/.local/share/nvim"
M.MASON_BIN = M.NVIM_LOCAL .. "/mason/bin"
M.MASON_PACKAGES = M.NVIM_LOCAL .. "/mason/packages"

M.OPTS = { noremap = true, silent = false }
M.NOWAIT_OPTS = { noremap = true, silent = false, nowait = true }
M.EXPR_OPTS = { noremap = true, silent = true, expr = true }
M.CMD_OPTS = { noremap = true }

-- Default blink.cmp keymap definitions
M.BLINK_KEYMAPS = {
  ["<C-Space>"] = { "show" },
  ["<C-c>"] = { "cancel", "fallback" },
  ["<Esc>"] = { "cancel", "fallback" },
  ["<CR>"] = { "select_and_accept", "fallback" },
  ["<Tab>"] = { "select_and_accept", "snippet_forward", "fallback" },
  ["<S-Tab>"] = { "snippet_backward", "fallback" },
  ["<Up>"] = { "select_prev", "fallback" },
  ["<Down>"] = { "select_next", "fallback" },
  ["<C-S-Up>"] = {
    function(cmp)
      cmp.scroll_documentation_up(3)
    end,
    "fallback",
  },
  ["<C-S-Down>"] = {
    function(cmp)
      cmp.scroll_documentation_down(3)
    end,
    "fallback",
  },
  ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
}

return M
