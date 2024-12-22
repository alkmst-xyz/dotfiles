return {
  -- configures Lua LSP for Neovim APIs, runtime and plugins
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim",          config = true },
      { "williamboman/mason-lspconfig.nvim" },
      { 'saghen/blink.cmp' },
    },

    -- LSP servers to setup
    opts = {
      servers = {
        lua_ls = {}
      }
    },

    config = function(_, opts)
      -- mason
      require("mason").setup()
      require("mason-lspconfig").setup()

      -- Calling setup for each LSP server
      local lspconfig = require("lspconfig")
      for server, config in pairs(opts.servers) do
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end

      -- Format the current buffer on write
      -- LspAttach is the key to know what to do when an LSP attaches to the buffer
      -- This autocmd runs on very 'LspAttach' event (this does not have a buffer event)
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          -- skip implementation and completion for now
          if not client then return end

          -- New autocmd that only listens on this buffer
          -- Format the current buffer on save
          ---@diagnostic disable-next-line: missing-parameter
          if client.supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end
        end,
      })
    end,
  }
}
