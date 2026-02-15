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

return M
