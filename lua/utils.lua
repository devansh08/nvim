local M = {}
local module_name = "utils"

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
	return string.format("<cmd>lua require('%s').apply_function(%s)<CR>", module_name, register_fn(fn))
end

function M.set_keymaps(mode, keymaps, keymap_opts, buffer_local)
	for k, v in pairs(keymaps) do
		keymap_opts["desc"] = v[2]
		if buffer_local then
			vim.api.nvim_buf_set_keymap(mode, k, v[1], keymap_opts)
		else
			vim.api.nvim_set_keymap(mode, k, v[1], keymap_opts)
		end
	end
end

return M
