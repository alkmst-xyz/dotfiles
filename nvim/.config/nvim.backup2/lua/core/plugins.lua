-- install package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


-- plugins can be configured using the `config` key or after the setup call,
-- since they will be available in the neovim runtime
require('lazy').setup({

  -- Colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,    -- load this during startup if it is your main colorscheme
    priority = 1000, -- load this before all the other start plugins
    opts = {
      style = "storm",
      light_style = "day",
      transparent = true,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      require("tokyonight").load() -- load the colorscheme here
    end,
  },

  -- Coding: LSP
  {
    'neovim/nvim-lspconfig',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- useful status updates for LSP
      {
        'j-hui/fidget.nvim',
        tag = "legacy",
        opts = {
          text = { spinner = "moon" },
          window = { blend = 0 }
        }
      },

      -- additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        severity_sort = true,
      },
      -- add any global capabilities here
      capabilities = {},
      -- Automatically format on save
      autoformat = true,
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overridden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      -- LSP enabled
      -- (1) each key is the server name
      -- (2) the value is the server spefic setting used in lspconfig
      servers = {
        jsonls = {},
        lua_ls = {},
        eslint = {},
        tsserver = {},
        pylsp = {
          plugins = {
            pyflakes = { enabled = false },
            pylint = { enabled = false },
            autopep8 = { enabled = false }
          },
        },
      },
      setup = {},
    },
    config = function(_, opts)
      -- helper function to attach keymaps to buffers with active LSP servers
      -- sets the mode, buffer and description for each server
      local on_attach = function(client, buf)
        -- helper function to map LSP commands
        local map = function(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end

          vim.keymap.set('n', keys, func,
            { noremap = true, silent = true, buffer = buf, desc = desc }
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

        -- dont format if client disabled it
        if
            client.config
            and client.config.capabilities
            and client.config.capabilities.documentFormattingProvider == false
        then
          return
        end

        -- create autocommand to save on write
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("LspFormat." .. buf, {}),
            buffer = buf,
            callback = function()
              vim.lsp.buf.format({ async = true })
            end,
          })
        end
      end

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = require("cmp_nvim_lsp").default_capabilities(
        vim.lsp.protocol.make_client_capabilities()
      )

      -- setup mason-lspconfig
      local mlsp = require("mason-lspconfig")

      -- ensure the servers are installed
      mlsp.setup({
        ensure_installed = vim.tbl_keys(opts.servers)
      })
      mlsp.setup_handlers({
        function(server_name)
          require('lspconfig')[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = opts.servers[server_name],
          })
        end,
      })
    end
  },

  -- Coding: install LSP servers, linters, formatters
  {
    'williamboman/mason.nvim',
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        "flake8",
        "prettierd"
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end
  },

  -- Coding: formatter
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim"
    },
    opts = function()
      local nls = require("null-ls")
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          nls.builtins.formatting.shfmt,
          nls.builtins.diagnostics.flake8,
          nls.builtins.formatting.black,
          nls.builtins.formatting.prettierd,
        },
      }
    end,
  },

  -- Coding: auto completion
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",

      -- snippets
      {
        "L3MON4D3/LuaSnip",
        dependencies = {
          "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
          end,
        },
        opts = {
          history = true,
          delete_check_events = "TextChanged",
        },
      }

    },
    opts = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      luasnip.config.setup {}

      return {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({
            select = true
          }),
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
          }),
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
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        }),
      }
    end
  },

  -- Coding: highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    version = nil,
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>",      desc = "Decrement selection", mode = "x" },
    },
    opts = {
      highlight = { enable = true },
      indent = { enable = true, disable = { "python" } },
      context_commentstring = { enable = true, enable_autocmd = false },
      ensure_installed = {
        "bash",
        "javascript",
        "json",
        "lua",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "typescript",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = "<nop>",
          node_decremental = "<bs>",
        },
      },
    },
    config = function(_, opts)
      pcall(require('nvim-treesitter.install').update { with_sync = true })
      require('nvim-treesitter.configs').setup(opts)
    end,
  },

  	-- coding: refactoring plugin
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("refactoring").setup()
		end,
	},

  -- Coding: auto pairs
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    config = function(_, opts)
      require("mini.pairs").setup(opts)
    end,
  },

  -- Coding: surround
  {
    'echasnovski/mini.surround',
    version = nil,
    config = function(_, opts)
      require("mini.surround").setup(opts)
    end,
  },

  -- Coding: commments
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require("mini.comment").setup(opts)
    end,
  },

  -- Editor: file explorer
  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
    },
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    opts = {
      close_if_last_window = true,
      window               = {
        width = 30,
      },
      filesystem           = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
      source_selector      = {
        winbar = true,
      }
    },
  },

  -- Editor: show keybinds when pressing <Space>
  {
    'folke/which-key.nvim',
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      local keymaps = {
        mode = { "n", "v" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>q"] = { "<cmd>bdelete<CR>", "Delete Buffer" },
      }
      wk.register(keymaps)
    end,
  },

  -- Editor: fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    tag          = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys         = {
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>",  desc = "status" },
    }
  },

  -- Editor: git signs on the side of the editor
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '▎' },
        topdelete = { text = '▎‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
    },
  },

  -- Editor: highlight references
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },

  -- Editor: todo comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    config = true,
  },

  -- UI: devicons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- UI: bottom statusline
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        always_divide_middle = true,
        globalstatus = true
      },
      sections = {
        lualine_a = { "hostname", },
        lualine_b = {
          { "branch", icon = "" },
          { 'diff',   colored = false }
        },
        lualine_c = {
          {
            "diagnostics",
            sources = { "nvim_lsp" },
            colored = false,
            update_in_insert = true,
            always_visible = true,
          },
          "mode"
        },
        lualine_x = { "encoding", "filetype" },
        lualine_y = { "location" },
        lualine_z = { "progress" },
      },
    },
  },

  -- UI: add indentation guides on blank lines
  {
    'akinsho/bufferline.nvim',
    event = "VeryLazy",
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
    end
  },

  -- UI: add indentation guides on blank lines
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      show_trailing_blankline_indent = false,
      show_current_context = true,
      show_current_context_start = true,
    },
    config = function()
      require("ibl").setup()
    end
  },


  -- UI: dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = [[
        ▄▄▄       ██▓     ██ ▄█▀ ███▄ ▄███▓  ██████ ▄▄▄█████▓
       ▒████▄    ▓██▒     ██▄█▒ ▓██▒▀█▀ ██▒▒██    ▒ ▓  ██▒ ▓▒
       ▒██  ▀█▄  ▒██░    ▓███▄░ ▓██    ▓██░░ ▓██▄   ▒ ▓██░ ▒░
       ░██▄▄▄▄██ ▒██░    ▓██ █▄ ▒██    ▒██   ▒   ██▒░ ▓██▓ ░
        ▓█   ▓██▒░██████▒▒██▒ █▄▒██▒   ░██▒▒██████▒▒  ▒██▒ ░
        ▒▒   ▓▒█░░ ▒░▓  ░▒ ▒▒ ▓▒░ ▒░   ░  ░▒ ▒▓▒ ▒ ░  ▒ ░░
         ▒   ▒▒ ░░ ░ ▒  ░░ ░▒ ▒░░  ░      ░░ ░▒  ░ ░    ░
         ░   ▒     ░ ░   ░ ░░ ░ ░      ░   ░  ░  ░    ░
             ░  ░    ░  ░░  ░          ░         ░
      ]]

      dashboard.section.header.val = vim.split(logo, "\n")
      dashboard.section.buttons.val = {
        dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
        dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("g", "  Find text", ":Telescope live_grep <CR>"),
        dashboard.button("l", "⏾  Lazy", ":Lazy<CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
      }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      dashboard.section.footer.opts.hl = "Type"
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)
    end,
  },

  -- TODO UI: file preview map like mini.map


}, {})
