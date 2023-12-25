local M = {}

M.HOME = os.getenv("HOME")

M.NVIM_LOCAL = M.HOME .. "/.local/share/nvim"
M.MASON_PACKAGES = M.NVIM_LOCAL .. "/mason/packages"

M.NVIM_CACHE = M.HOME .. "/.cache/nvim"

return M
