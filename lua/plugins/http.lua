return {
  {
    "mistweaverco/kulala.nvim",
    version = "*",
    lazy = true,
    ft = { "http", "rest" },
    -- Reference: https://neovim.getkulala.net/docs/getting-started/configuration-options/
    opts = {
      additional_curl_options = { "-L" },
      ui = {
        win_opts = { bo = { readonly = true }, wo = {} },
        winbar = false,
        icons = {
          inlay = {
            loading = "",
            done = "",
            error = "",
          },
        },
        disable_script_print_output = true,
        disable_news_popup = true,
      },
      global_keymaps_prefix = "<leader>h",
    },
  },
}
