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
    },
    config = function()
      -- mason
      require("mason").setup()
      require("mason-lspconfig").setup()

      -- LSP servers
      require("lspconfig").lua_ls.setup({})

      -- autocmd to format the current buffer on write
      -- LspAttach is the key to know what to do when an LSP attaches to the buffer
      -- This autocmd on very 'LspAttach' event (this does not have a buffer event)
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          -- skip implementation and completion for now
          if not client then return end

          -- This autocmd only listens on this buffer
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
