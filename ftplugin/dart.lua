vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "dartls" })

lvim.builtin.which_key.mappings["F"] = { "<cmd>Telescope flutter commands<CR>", "Flutter commands" }

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
      require("dap").configurations.dart = {}
      require("dap.ext.vscode").load_launchjs()
    end,
    run_via_dap = false,
  },
  widget_guides = {
    enabled = true,
  },
  dev_log = {
    enabled = false,
    open_cmd = "10new"
  },
})

require 'luasnip'.filetype_extend("dart", { "flutter" })
