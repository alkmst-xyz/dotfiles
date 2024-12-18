return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },
  config = function()
    require('telescope').setup {
      pickers = {
        -- set default theme for all find_files
        find_files = {
          theme = "ivy"
        }
      },
      extensions = {
        fzf = {}
      }
    }

    -- load fzf native
    require('telescope').load_extension('fzf')

    -- open telescope help
    vim.keymap.set("n", "<space>fh", require("telescope.builtin").help_tags)

    -- open telescope in the current directory
    vim.keymap.set("n", "<space>fd", require("telescope.builtin").find_files)

    -- open neovim config from anywhere
    vim.keymap.set("n", "<space>ne", function()
      require("telescope.builtin").find_files({
        cwd = vim.fn.stdpath("config")
      })
    end)

    -- open neovim plugin internals from anywhere
    vim.keymap.set("n", "<space>np", function()
      require("telescope.builtin").find_files({
        cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
      })
    end)
  end
}
