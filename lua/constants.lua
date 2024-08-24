local M = {}

M.HOME = os.getenv("HOME")

M.NVIM_LOCAL = M.HOME .. "/.local/share/nvim"
M.MASON_PACKAGES = M.NVIM_LOCAL .. "/mason/packages"

M.NVIM_CACHE = M.HOME .. "/.cache/nvim"

M.OPTS = { noremap = true, silent = true }
M.EXPR_OPTS = { noremap = true, silent = true, expr = true }
M.CMD_OPTS = { noremap = true }
M.CMD_EXPR_OPTS = { noremap = true, expr = true }

return M
