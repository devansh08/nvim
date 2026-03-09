return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    branch = "master",
    lazy = true,
    event = "BufReadPost",
    -- Reference: https://github.com/nvim-treesitter/nvim-treesitter-context?tab=readme-ov-file#configuration
    opts = {
      enable = true,
      max_lines = 2,
    },
  },
  {
    "hiphish/rainbow-delimiters.nvim",
    branch = "master",
    lazy = true,
    event = "BufReadPost",
  },
  {
    "windwp/nvim-ts-autotag",
    branch = "main",
    lazy = true,
    ft = { "html", "xml", "typescriptreact", "javascriptreact" },
    -- Reference: https://github.com/windwp/nvim-ts-autotag?tab=readme-ov-file#setup
    opts = {
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local utils = require("utils")
      local constants = require("constants")

      local set_keymaps = utils.set_keymaps
      local lua_fn = utils.lua_fn
      local opts = constants.OPTS

      require("nvim-treesitter-textobjects").setup({})

      -- Reference: https://github.com/nvim-treesitter/nvim-treesitter-textobjects/tree/main?tab=readme-ov-file#text-objects-select
      ---@param mappings string[][]
      local select_keymaps = function(mappings)
        ---@type table<string, string[]>
        local keymaps = {}

        for _, mapping in ipairs(mappings) do
          keymaps["i" .. mapping[1]] = {
            lua_fn(function()
              require("nvim-treesitter-textobjects.select").select_textobject(
                "@" .. mapping[2] .. ".inner",
                "textobjects"
              )
            end),
            "TreesitterTextobjects: Select Inside " .. mapping[3],
          }
          keymaps["a" .. mapping[1]] = {
            lua_fn(function()
              require("nvim-treesitter-textobjects.select").select_textobject(
                "@" .. mapping[2] .. ".outer",
                "textobjects"
              )
            end),
            "TreesitterTextobjects: Select Outside " .. mapping[3],
          }
        end

        set_keymaps("o", keymaps, opts)
        set_keymaps("x", keymaps, opts)
      end

      select_keymaps({
        { "f", "function", "Function" },
        { "c", "class", "Class" },
        { "C", "conditional", "Conditional" },
        { "l", "loop", "Loop" },
      })

      -- Reference: https://github.com/nvim-treesitter/nvim-treesitter-textobjects/tree/main?tab=readme-ov-file#text-objects-move
      ---@param mappings string[][]
      local move_keymaps = function(mappings)
        ---@type table<string, string[]>
        local keymaps = {}

        for _, mapping in ipairs(mappings) do
          keymaps["[" .. mapping[1]] = {
            lua_fn(function()
              require("nvim-treesitter-textobjects.move").goto_previous("@" .. mapping[2] .. ".outer", "textobjects")
            end),
            "TreesitterTextobjects: Move to Prev " .. mapping[3],
          }
          keymaps["]" .. mapping[1]] = {
            lua_fn(function()
              require("nvim-treesitter-textobjects.move").goto_next("@" .. mapping[2] .. ".outer", "textobjects")
            end),
            "TreesitterTextobjects: Move to Next " .. mapping[3],
          }
        end

        set_keymaps("n", keymaps, opts)
        set_keymaps("o", keymaps, opts)
        set_keymaps("x", keymaps, opts)
      end

      move_keymaps({
        { "f", "function", "Function" },
        { "c", "class", "Class" },
        { "C", "conditional", "Conditional" },
        { "l", "loop", "Loop" },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    version = "*",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync" },
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "hiphish/rainbow-delimiters.nvim",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      local utils = require("utils")
      local check_executable = utils.check_executable

      require("nvim-treesitter.configs").setup({
        ensure_installed = check_executable({
          ["bash"] = { { "bash" } },
          ["c"] = { { "gcc" } },
          ["cpp"] = { { "g++" } },
          ["css"] = {},
          ["dockerfile"] = { { "docker" }, { "pulumi" } },
          ["fish"] = { { "fish" } },
          ["go"] = { { "go" } },
          ["html"] = {},
          ["java"] = { { "java" } },
          ["javascript"] = { { "node", "npm" }, { "bun" } },
          ["jsdoc"] = { { "node", "npm" }, { "bun" } },
          ["json"] = {},
          ["json5"] = {},
          ["jsonc"] = {},
          ["kotlin"] = { { "kotlin" } },
          ["lua"] = { { "lua" } },
          ["markdown"] = {},
          ["python"] = { { "python", "pip" } },
          ["rust"] = { { "rustc" } },
          ["scss"] = {},
          ["sql"] = { { "mysql" } },
          ["toml"] = {},
          ["tsx"] = { { "node", "npm" }, { "bun" } },
          ["typescript"] = { { "node", "npm" }, { "bun" } },
          ["vim"] = {},
          ["vimdoc"] = {},
          ["yaml"] = {},
          ["zig"] = { { "zig" } },
        }),
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },
}
