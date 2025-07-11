local options = {
  number = true,
  relativenumber = true,
  cursorline = true,
  numberwidth = 4,

  signcolumn = "yes",

  mouse = "",
  clipboard = "unnamedplus",

  splitbelow = true,
  splitright = true,

  scrolloff = 8,
  sidescrolloff = 20,
  wrap = true,

  completeopt = { "menuone", "preview", "noselect" },
  pumheight = 20,
  updatetime = 250,

  hlsearch = true,
  incsearch = true,
  ignorecase = true,
  smartcase = true,

  smartindent = true,
  autoindent = true,
  expandtab = true,
  shiftwidth = 2,
  tabstop = 2,

  undofile = true,

  termguicolors = true,

  showmode = false,
  shortmess = "filnxtToOFmrwsWcCS",

  foldenable = true,
  foldcolumn = "1",
  foldlevel = 99,
  foldlevelstart = 99,

  cmdheight = 0,
  conceallevel = 0,

  showtabline = 0,

  winborder = "single",
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.iskeyword:remove({ "-", "_" })
vim.opt.whichwrap:append({
  ["<"] = true,
  [">"] = true,
  ["["] = true,
  ["]"] = true,
})

vim.cmd([[ command! Q q ]])
vim.cmd([[ command! W w ]])
vim.cmd([[ command! Wq wq ]])

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.skip_ts_context_commentstring_module = true

vim.api.nvim_set_hl(0, "DapColors", { fg = "#F38BA8" })
vim.fn.sign_define("DapBreakpoint", { text = "󰏃", texthl = "DapColors", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapColors", linehl = "", numhl = "" })
