return {
  {
    "nvim-tree/nvim-tree.lua",
    branch = "master",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    -- Reference: |nvim-tree-default-config|
    opts = {
      disable_netrw = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = {
          enable = true,
        },
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      git = {
        enable = true,
      },
      modified = {
        enable = true,
      },
      filesystem_watchers = {
        enable = true,
      },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
          return {
            desc = "nvim-tree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
          }
        end

        local keymap = function(k, v, opt)
          vim.keymap.set("n", k, v, opt)
        end

        -- Defaults |nvim-tree-mappings-default|
        api.map.on_attach.default(bufnr)

        -- Overrides
        keymap("y", api.fs.copy.node, opts("Tree: Copy"))
        keymap("c", api.fs.copy.filename, opts("Tree: Copy Name"))
        keymap("D", api.fs.remove, opts("Tree: Delete"))
        keymap("d", api.fs.trash, opts("Tree: Send to Trash"))
      end,
      select_prompts = true,
      view = {
        width = 30,
        float = {
          enable = false,
        },
      },
      renderer = {
        group_empty = true,
        highlight_git = true,
        indent_markers = {
          enable = true,
        },
      },
      filters = {
        enable = true,
        custom = {
          "^.git$",
          ".null-ls*",
          "*.class",
          "*.out",
          "*.jar",
          ".out-*",
          "__pycache__",
        },
      },
      actions = {
        change_dir = {
          enable = false,
        },
        expand_all = {
          exclude = {
            ".git",
            "dist",
            "target",
            "build",
            ".vscode",
          },
        },
        file_popup = {
          open_win_config = {
            border = "single",
          },
        },
      },
      tab = {
        sync = {
          open = true,
          close = true,
        },
      },
    },
  },
}
