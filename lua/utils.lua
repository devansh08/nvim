local M = {}
local module_name = 'utils'

-- Using functions for keymaps: https://gist.github.com/VonHeikemen/dd2190709302de7ee9943f1b9dfb1933
local fn_store = {}

local function register_fn(fn)
  table.insert(fn_store, fn)
  return #fn_store
end

function M.apply_function(id)
  fn_store[id]()
end

function M.lua_fn(fn)
  return string.format(
    "<cmd>lua require('%s').apply_function(%s)<CR>",
    module_name,
    register_fn(fn)
  )
end

return M
