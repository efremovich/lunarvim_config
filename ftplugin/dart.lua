vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "dartls" })


require("flutter-tools").setup({
  -- flutter_path = "/home/padre/snap/flutter/common/flutter/",
  lsp = {
    color = {
      enabled = true,
    },
    on_attach = function(client, bufnr)
      require("lvim.lsp").common_on_attach(client, bufnr)
    end,
    capabilities = require("lsp-status").capabilities,
  },
  debugger = {
    enabled = true,
    runregister_configurations = function(_)
      require("dap").configurations.dart = {
        type = "dart",
        request = "launch",
        name = "Launch flutter",
        program = "${workspaceFolder}/lib/main.dart",
        cwd = "${workspaceFolder}",
        args = { '-d', 'linux' }
      }
      require("dap.ext.vscode").load_launchjs()
    end,
    run_via_dap = true,
  },
  widget_guides = {
    enabled = true,
  },
  dev_log = {
    enabled = true,
    open_cmd = "tabedit"
  },
})

require 'luasnip'.filetype_extend("dart", { "flutter" })
lvim.builtin.which_key.mappings["F"] = { "<cmd>Telescope flutter commands<CR>", "Flutter commands" }
