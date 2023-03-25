-- LSP setup

-- helper function to attach keymaps to buffers with active LSP servers
-- sets the mode, buffer and description for each server
local on_attach = function(_, bufnr)
  -- helper function to map LSP commands
  local map = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set('n', keys, func,
      { noremap = true, silent = true, buffer = bufnr, desc = desc }
    )
  end

  map('gD', vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  map('gd', vim.lsp.buf.definition, "[G]oto [D]efinition")
  map('gi', vim.lsp.buf.implementation, "List [I]mplementations")
  map('gr', vim.lsp.buf.references, "List [R]eferences")

  map('K', vim.lsp.buf.hover, "Hover Documentation")
  map('<C-k>', vim.lsp.buf.signature_help, "Signature Documentation")

  map('<leader>wa', vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  map('<leader>wr', vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  map('<leader>wl',
    function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end,
    "[W]orkspace [L]ist Folders"
  )

  map('<leader>D', vim.lsp.buf.type_definition, "Type [D]efinition")
  map('<leader>rn', vim.lsp.buf.rename, "[R]e[n]ame")
  map('<leader>ca', vim.lsp.buf.code_action, "[C]ode [A]ction")
  map('<leader>f',
    function()
      vim.lsp.buf.format({ async = true })
    end,
    "Format"
  )

  -- map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  -- map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  -- map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  -- map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  -- map('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  -- map('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  -- map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  -- map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- -- See `:help K` for why this keymap
  -- map('K', vim.lsp.buf.hover, 'Hover Documentation')
  -- map('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- -- Lesser used LSP functionality
  -- map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  -- map('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  -- map('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  -- map('<leader>wl',
  --   function()
  --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  --   end, '[W]orkspace [L]ist Folders')

  -- -- Create a command `:Format` local to the LSP buffer
  -- vim.api.nvim_buf_create_user_command(
  --   bufnr,
  --   'Format',
  --   function(_)
  --     vim.lsp.buf.format()
  --   end,
  --   { desc = 'Format current buffer with LSP' }
  -- )
end

-- language servers to be enabled
-- (1) each key is the server name
-- (2) the value is the server spefic setting used in lspconfig
local servers = {
  eslint = {},
  tsserver = {},
  lua_ls = {},
  pylsp = {},
}

-- setup neovim lua configuration
require("neodev").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = require("cmp_nvim_lsp").default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

-- setup mason so it can manage external tooling
require("mason").setup()
local mason_lspconfig = require("mason-lspconfig")

-- ensure the servers are installed
mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
  function(server_name)
    require('lspconfig')[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    })
  end,
})


-- Completion setup
local cmp = require('cmp')
local luasnip = require('luasnip')

-- load snippets
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end,
      { 'i', 's' }
    ),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end,
      { 'i', 's' }
    ),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<S-CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }),
})
