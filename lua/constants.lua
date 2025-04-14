local M = {}

M.HOME = os.getenv("HOME")

M.NVIM_CONFIG = M.HOME .. "/.config/nvim"

M.NVIM_LOCAL = M.HOME .. "/.local/share/nvim"
M.MASON_BIN = M.NVIM_LOCAL .. "/mason/bin"
M.MASON_PACKAGES = M.NVIM_LOCAL .. "/mason/packages"

M.NVIM_CACHE = M.HOME .. "/.cache/nvim"

M.OPTS = { noremap = true, silent = false }
M.EXPR_OPTS = { noremap = true, silent = true, expr = true }
M.CMD_OPTS = { noremap = true }
M.CMD_EXPR_OPTS = { noremap = true, expr = true }

return M
