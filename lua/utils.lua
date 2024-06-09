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
			vim.api.nvim_buf_set_keymap(0, mode, k, v[1], keymap_opts)
		else
			vim.api.nvim_set_keymap(mode, k, v[1], keymap_opts)
		end
	end
end

function M.check_executable(t)
	local list = {}

	for key, execs in pairs(t) do
		if #execs == 0 then
			table.insert(list, key)
		end

		for _, group in pairs(execs) do
			local flag = true
			for _, v in pairs(group) do
				if vim.fn.executable(v) ~= 1 then
					flag = false
				end
			end

			if flag then
				table.insert(list, key)
				break
			end
		end
	end

	return list
end

function M.string_starts_with(str, pat)
	return str:sub(1, #pat) == pat
end

function M.file_exists_in_root(file)
	return vim.fn.findfile(file, vim.loop.cwd()) == file
end

function M.table_contains(t, key)
	for _, value in ipairs(t) do
		if value == key then
			return true
		end
	end

	return false
end

function M.get_visual_selection()
	return vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })[1]
end

return M
