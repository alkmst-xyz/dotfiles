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

  -- Editor
  -- browse file tree
  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {},
  },

  -- show you pending keybinds
  { 'folke/which-key.nvim', opts = {} },

  -- -- Adds git releated signs to the gutter, as well as utilities for managing changes
  -- {
  --   'lewis6991/gitsigns.nvim',
  --   opts = {
  --     -- See `:help gitsigns.txt`
  --     signs = {
  --       add = { text = '+' },
  --       change = { text = '~' },
  --       delete = { text = '_' },
  --       topdelete = { text = '‾' },
  --       changedelete = { text = '~' },
  --     },
  --   },
  -- },

  -- -- statusline
  -- {
  --   'nvim-lualine/lualine.nvim',
  --   opts = {
  --     options = {
  --       icons_enabled = false,
  --       theme = 'onedark',
  --       component_separators = '|',
  --       section_separators = '',
  --     },
  --   },
  -- },

  -- -- Add indentation guides even on blank lines
  -- {
  --   'lukas-reineke/indent-blankline.nvim',
  --   opts = {
  --     char = '┊',
  --     show_trailing_blankline_indent = false,
  --   },
  -- },

}, {})
