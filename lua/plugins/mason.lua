local servers = {
  pylsp = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = { "E203", "E701", "W503" },
          maxLineLength = 88,
        },
        isort = {
          enabled = true,
          profile = "black",
        },
      },
    },
  },
  clangd = {},
  clang_format = {},
}
return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers),
      })

      mason_lspconfig.setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
          })
        end,
      })
    end,
  },
}
