local M = {}
local module_name = "utils"

---Using functions for keymaps: https://gist.github.com/VonHeikemen/dd2190709302de7ee9943f1b9dfb1933
---@type function[]
local fn_store = {}

---Adds function to the `fn_store` table
---@param fn function Function wrapper to be executed for keymap
---@return integer _ Length of `fn_store` array
local function register_fn(fn)
  table.insert(fn_store, fn)
  return #fn_store
end

---Executes indexed function from `fn_store`
---@param id integer Index of function to use from `fn_store`
function M.apply_function(id)
  fn_store[id]()
end

---Creates wrapper function for keymap Lua function
---@param fn function Function to be executed for keymap
---@return string _ Lua command to execute keymap function
function M.lua_fn(fn)
  return string.format("<cmd>lua require('%s').apply_function(%s)<CR>", module_name, register_fn(fn))
end

---@param mode string VIM mode for keymap
---@param keymaps table<string, string[]> Table of keymap data. Key is the LHS of the keymap. Value is the _required_ RHS and description for the keymap.
---@param keymap_opts table<string, boolean|string> Keymap options to be passed to set_keymap API
---@param buffer_local? boolean _Optional_ Flag to make keymap buffer only
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

---Checks if executable is present on the system. Returns string array of keys with present executables.
---@param t table<string, string[][]>
---@return string[] list List of keys whose values are executables present in the system
function M.check_executable(t)
  ---@type string[]
  local list = {}

  for key, execs in pairs(t) do
    if #execs == 0 then
      table.insert(list, key)
    end

    for _, group in pairs(execs) do
      ---@type boolean
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

---Check if string starts with pattern
---@param str string Input string
---@param pat string Pattern to check at start of `str`
---@return boolean _ True, if `str` starts with `pat`. False, otherwise.
function M.string_starts_with(str, pat)
  return str:sub(1, #pat) == pat
end

---Check if file exists in the root directory of open project
---@param file string[]|string Single file name or list of file names to search for in the root directory
---@return boolean _ True, if file is found in the root directory. False, otherwise.
function M.file_exists_in_root(file)
  if type(file) == "table" then
    local flag = false
    for _, f in ipairs(file) do
      if vim.fn.findfile(f, vim.env.PWD) == f then
        flag = true
      end
      break
    end

    return flag
  else
    return vim.fn.findfile(file, vim.env.PWD) == file
  end
end

---Check if table contains given key
---@param t table<any, any> Input table
---@param key any Key to be checked if present in table `t`
---@return boolean _ True, if key is found in the table. False, otherwise.
function M.table_contains(t, key)
  for _, value in ipairs(t) do
    if value == key then
      return true
    end
  end

  return false
end

---Get the text of visual selection
---@return string _ Text from visual selection
function M.get_visual_selection()
  return vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })[1]
end

---Bulk add elements of one table into another
---@param cur table<any, any> Existing table
---@param new table<any, any> Table whose elements need to be added into `cur`
function M.table_extend(cur, new)
  for _, v in ipairs(new) do
    table.insert(cur, v)
  end
end

return M
