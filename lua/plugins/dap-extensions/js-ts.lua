return {
  "mxsdev/nvim-dap-vscode-js",
  branch = "main",
  lazy = true,
  config = function()
    local dap = require("dap")

    local constants = require("constants")

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "8888",
      executable = {
        command = "node",
        args = { constants.MASON_PACKAGES .. "/js-debug-adapter/js-debug/src/dapDebugServer.js", 8888 },
      },
    }

    for _, language in ipairs({ "typescript", "javascript" }) do
      dap.configurations[language] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch File",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach Debugger",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }
    end
  end,
}
