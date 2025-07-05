return {
  "akinsho/toggleterm.nvim",
  branch = "main",
  config = function()
    local opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return 80
        end
      end,
      open_mapping = "<C-E>",
      hide_numbers = true,
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
      close_on_exit = true,
      auto_scroll = true,
      --      persist_mode = false,
      start_in_insert = true,
    }

    require("toggleterm").setup(opts)
  end,
}
