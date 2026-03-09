return {
  {
    "akinsho/toggleterm.nvim",
    branch = "main",
    -- Reference = https://github.com/akinsho/toggleterm.nvim?tab=readme-ov-file#setup
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return 80
        end
      end,
      open_mapping = "<C-e>",
      direction = "float",
      float_opts = {
        border = "single",
        width = function()
          return math.floor(vim.o.columns * 0.9)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.8)
        end,
      },
      winbar = {
        enabled = false,
      },
    },
  },
}
