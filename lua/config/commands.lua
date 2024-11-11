local cmd = vim.api.nvim_create_user_command

cmd("DisableAutoFormat", "lua vim.g.force_disable_autoformat = true", {})
cmd("EnableAutoCompletion", function()
  vim.g.enable_auto_completion = true
  vim.cmd("Lazy reload cmp-nvim-lua")
end, {})
