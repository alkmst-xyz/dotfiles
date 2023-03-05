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
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },


  -- Coding: LSP
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  -- Coding: snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",

    },
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
    },
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
    config = function()
      require("neo-tree").setup()
    end,
    opts = {},
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

  -- -- "gc" to comment visual regions/lines
  -- { 'numToStr/Comment.nvim', opts = {} },

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

  -- UI: Add indentation guides even on blank lines
  { 'lukas-reineke/indent-blankline.nvim' },

}, {})
