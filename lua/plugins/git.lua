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
        focusable = true,
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
    lazy = true,
    cmd = "DiffviewOpen",
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
  {
    "NeogitOrg/neogit",
    branch = "master",
    lazy = true,
    cmd = "Neogit",
    config = function()
      require("neogit").setup({
        disable_insert_on_commit = true,
        graph_style = "kitty",
        git_services = {
          ["github.com"] = {
            pull_request = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
            commit = "https://github.com/${owner}/${repository}/commit/${oid}",
            tree = "https://${host}/${owner}/${repository}/tree/${branch_name}",
          },
        },
        remember_settings = false,
        use_per_project_settings = false,
        kind = "tab",
        commit_editor = {
          spell_check = false,
        },
        signs = {
          hunk = { "", "" },
          item = { "", "" },
          section = { "", "" },
        },
        mappings = {
          commit_editor = {
            ["<c-c><c-c>"] = false,
            ["<c-c><c-k>"] = false,
          },
          commit_editor_I = {
            ["<c-c><c-c>"] = false,
            ["<c-c><c-k>"] = false,
          },
          status = {
            ["<cr>"] = "Toggle",
            ["<s-cr>"] = "GoToFile",
            ["o"] = false,
          },
        },
      })

      if vim.g.active_colorscheme_variant == "terafox" then
        vim.api.nvim_set_hl(0, "NeogitDiffAdd", {
          fg = "#8eB2AF",
          bg = "#0f1c1e",
        })
        vim.api.nvim_set_hl(0, "NeogitDiffAddHighlight", {
          bg = "#1d3337",
        })
        vim.api.nvim_set_hl(0, "NeogitDiffContextHighlight", {
          bg = "#0f1c1e",
        })
      end
    end,
  },
}
