return {
  {
    "dmtrKovalenko/fff.nvim",
    version = "*",
    lazy = false,
    build = function()
      require("fff.download").download_or_build_binary()
    end,
    -- Reference: https://github.com/dmtrKovalenko/fff#lazynvim
    opts = {
      prompt = "> ",
      max_results = 10000,
      layout = {
        prompt_position = "top",
        preview_position = "right",
      },
      keymaps = {
        close = { "<Esc>", "<C-c>" },
        select = "<CR>",
        select_split = "<C-x>",
        select_vsplit = "<C-v>",
        select_tab = "<C-t>",
        move_up = "<Up>",
        move_down = "<Down>",
        preview_scroll_up = "<C-S-Up>",
        preview_scroll_down = "<C-S-Down>",
        toggle_debug = "<F2>",
        cycle_grep_modes = "<S-Tab>",
        cycle_previous_query = "<S-Up>",
        toggle_select = "<Tab>",
        send_to_quickfix = "<C-q>",
        focus_list = "<A-l>",
        focus_preview = "<A-p>",
      },
      logging = {
        enabled = false,
      },
    },
  },
}
