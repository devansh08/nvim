local cmd = vim.api.nvim_create_user_command

cmd("DisableAutoFormat", "lua vim.g.force_disable_autoformat = true", {})
cmd("EnableAutoCompletion", function()
  vim.g.enable_auto_completion = true
  vim.cmd("Lazy reload cmp-nvim-lua")
end, {})
-- Nop command to lazy start neotest when required
cmd("EnableNeotest", function() end, {})
cmd("FocusFloating", function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative ~= "" then
      vim.api.nvim_set_current_win(win)
      break
    end
  end
end, {})
