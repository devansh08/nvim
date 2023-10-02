-- Reload currently edited config (lua/config/*.lua) file
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "**/lua/config/*.lua",
  callback = function()
    dofile(vim.fn.expand("%"))
  end,
  group = vim.api.nvim_create_augroup("ReloadConfig", { clear = true }),
})

-- Better help navigation
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<C-]>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "n", "<BS>", "<C-T>", { noremap = true })
  end,
  group = vim.api.nvim_create_augroup("HelpNavigation", { clear = true }),
})

-- Auto open nvim-tree on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function(data)
    local real_file = vim.fn.filereadable(data.file) == 1
    local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

    if not real_file and not no_name then
      return
    end

    local status, nvim_tree_api = pcall(require, "nvim-tree.api")
    if not status then
      print("Error: require nvim-tree.api failed")
      return
    end

    if nvim_tree_api.toggle ~= nil then
      nvim_tree_api.toggle({ focus = false, find_file = true })
    end
  end,
  group = vim.api.nvim_create_augroup("AutoStartNvimTree", { clear = true }),
})

-- Auto switch to file buffer when changing windows or close nvim-tree buffer if it is the last buffer
vim.api.nvim_create_autocmd("WinLeave", {
  callback = function()
    if vim.bo.filetype == "NvimTree" then
      if vim.fn.tabpagewinnr(vim.fn.tabpagenr(), "$") == 1 then
        vim.cmd("q")
      else
        vim.cmd("wincmd p")
      end
    end
  end,
  group = vim.api.nvim_create_augroup("SwitchAwayFromNvimTreeBuffer", { clear = true }),
})

