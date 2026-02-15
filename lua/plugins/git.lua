return {
  {
    "lewis6991/gitsigns.nvim",
    version = "*",
    lazy = true,
    event = "VeryLazy",
    -- Reference: https://github.com/lewis6991/gitsigns.nvim?tab=readme-ov-file#%EF%B8%8F-installation--usage
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "┃" },
        delete = { text = "-", show_count = true },
        topdelete = { text = "-", show_count = true },
        changedelete = { text = "~", show_count = true },
        untracked = { text = "┆" },
      },
      signs_staged = {
        add = { text = "│" },
        change = { text = "┃" },
        delete = { text = "-", show_count = true },
        topdelete = { text = "-", show_count = true },
        changedelete = { text = "~", show_count = true },
        untracked = { text = "┆" },
      },
      attach_to_untracked = true,
      current_line_blame_opts = {
        virt_text_priority = 1000,
        delay = 0,
        ignore_whitespace = true,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      status_formatter = function(status)
        local added, changed, removed = status.added, status.changed, status.removed
        local status_txt = {}

        if added and added > 0 then
          table.insert(status_txt, "+" .. added)
        end

        if changed and changed > 0 then
          table.insert(status_txt, "~" .. changed)
        end

        if removed and removed > 0 then
          table.insert(status_txt, "-" .. removed)
        end

        return table.concat(status_txt, " ")
      end,
      preview_config = {
        border = "single",
      },
    },
  },
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    lazy = true,
    event = "VeryLazy",
    -- Reference: https://github.com/akinsho/git-conflict.nvim?tab=readme-ov-file#configuration
    opts = {
      default_mappings = false,
    },
  },
  {
    "sindrets/diffview.nvim",
    branch = "main",
    lazy = "true",
    cmd = "DiffViewOpen",
    -- Reference: https://github.com/sindrets/diffview.nvim?tab=readme-ov-file#configuration
    opts = {
      view = {
        default = {
          layout = "diff2_horizontal",
          disable_diagnostics = false,
          winbar_info = false,
        },
        merge_tool = {
          layout = "diff3_horizontal",
          disable_diagnostics = true,
          winbar_info = true,
        },
        file_history = {
          layout = "diff2_horizontal",
          disable_diagnostics = false,
          winbar_info = false,
        },
      },
    },
  },
}
