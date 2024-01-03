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

function M.add_null_ls_source(null_ls, sources)
	local ignore_func = function(filename)
		return function(utils)
			return not utils.root_has_file(filename)
		end
	end

	local setup = {}

	if #sources == 3 then
		local code_actions = sources[1]["code_actions"]
		for _, v in pairs(code_actions) do
			if #v == 1 then
				table.insert(setup, null_ls.builtins.code_actions[v[1]].with({ condition = ignore_func(".ignore-ca") }))
			elseif #v == 2 then
				table.insert(setup, null_ls.builtins.code_actions[v[1]].with(v[2]))
			end
		end

		local diagnostics = sources[2]["diagnostics"]
		for _, v in pairs(diagnostics) do
			if #v == 1 then
				table.insert(
					setup,
					null_ls.builtins.diagnostics[v[1]].with({ condition = ignore_func(".ignore-diag") })
				)
			elseif #v == 2 then
				table.insert(setup, null_ls.builtins.diagnostics[v[1]].with(v[2]))
			end
		end

		local formatting = sources[3]["formatting"]
		for _, v in pairs(formatting) do
			if #v == 1 then
				table.insert(setup, null_ls.builtins.formatting[v[1]].with({ condition = ignore_func(".ignore-fmt") }))
			elseif #v == 2 then
				table.insert(setup, null_ls.builtins.formatting[v[1]].with(v[2]))
			end
		end
	end

	return setup
end

function M.get_visual_selection()
	local visual_pos = vim.fn.getpos("v")
	local ls = visual_pos[2]
	local cs = visual_pos[3]

	local cursor_pos = vim.fn.getpos(".")
	local le = cursor_pos[2]
	local ce = cursor_pos[3]

	return vim.api.nvim_buf_get_text(0, ls - 1, cs - 1, le - 1, ce, {})[1]
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

return M
