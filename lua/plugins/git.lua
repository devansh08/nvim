return {
  {
    "lewis6991/gitsigns.nvim",
    branch = "main",
    cond = vim.fn.isdirectory('.git') == 1,
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_", show_count = true },
        topdelete = { text = "‾", show_count = true },
        changedelete = { text = "~", show_count = true },
        untracked = { text = "┆" },
      },
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      watch_gitdir = {
        enable = true,
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 0,
        ignore_whitespace = true,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      sign_priority = 6,
      update_debounce = 100,
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
      max_file_length = 40000,
      preview_config = {
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      yadm = {
        enable = false,
      },
    },
  },
}

