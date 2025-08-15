return {
  {
    "mistweaverco/kulala.nvim",
    version = "*",
    lazy = true,
    ft = { "http", "rest" },
    opts = {
      curl_path = "curl",
      additional_curl_options = { "-L" },
      openssl_path = "openssl",
      environment_scope = "b",
      default_env = "dev",
      request_timeout = nil,
      halt_on_error = true,
      certificates = {},
      urlencode = "skipencoded",
      infer_content_type = true,
      contenttypes = {
        ["application/json"] = {
          ft = "json",
          formatter = vim.fn.executable("jq") == 1 and { "jq", "." },
          pathresolver = function(...)
            return require("kulala.parser.jsonpath").parse(...)
          end,
        },
        ["application/graphql"] = {
          ft = "graphql",
          formatter = vim.fn.executable("prettier") == 1
            and { "prettier", "--stdin-filepath", "graphql", "--parser", "graphql" },
          pathresolver = nil,
        },
        ["application/xml"] = {
          ft = "xml",
          formatter = vim.fn.executable("xmllint") == 1 and { "xmllint", "--format", "-" },
          pathresolver = vim.fn.executable("xmllint") == 1 and { "xmllint", "--xpath", "{{path}}", "-" },
        },
        ["text/html"] = {
          ft = "html",
          formatter = vim.fn.executable("xmllint") == 1 and { "xmllint", "--format", "--html", "-" },
          pathresolver = nil,
        },
      },
      scripts = {
        node_path_resolver = nil,
      },
      ui = {
        display_mode = "split",
        split_direction = "vertical",
        win_opts = { bo = { readonly = true }, wo = {} },
        default_view = "body",
        winbar = false,
        show_variable_info_text = false,
        show_icons = "on_request",
        icons = {
          inlay = {
            loading = "",
            done = "",
            error = "",
          },
          textHighlight = "WarningMsg",
        },
        syntax_hl = {
          ["@punctuation.bracket.kulala_http"] = "Number",
          ["@character.special.kulala_http"] = "Special",
          ["@operator.kulala_http"] = "Special",
          ["@variable.kulala_http"] = "String",
        },
        show_request_summary = true,
        disable_script_print_output = true,
        report = {
          show_script_output = true,
          show_asserts_output = true,
          show_summary = true,
          headersHighlight = "Special",
          successHighlight = "String",
          errorHighlight = "Error",
        },
        scratchpad_default_contents = {
          "@MY_TOKEN_NAME=my_token_value",
          "",
          "# @name scratchpad",
          "POST https://httpbin.org/post HTTP/1.1",
          "accept: application/json",
          "content-type: application/json",
          "",
          "{",
          '  "foo": "bar"',
          "}",
        },
        disable_news_popup = true,
        lua_syntax_hl = true,
      },
      lsp = {
        enable = true,
        keymaps = false,
        formatter = {
          sort = {
            metadata = true,
            variables = true,
            commands = false,
            json = true,
          },
        },
        on_attach = nil,
      },
      debug = 3,
      generate_bug_report = false,
      global_keymaps = true,
      global_keymaps_prefix = "<leader>h",
      kulala_keymaps = true,
      kulala_keymaps_prefix = "",
    },
  },
}
