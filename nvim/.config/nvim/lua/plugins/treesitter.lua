return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs =  require('nvim-treesitter.configs')

      configs.setup {
	ensure_installed = { "c", "lua", "query", "markdown", "markdown_inline", "python", "typescript", "go" },
	auto_install = false,
	highlight = {
	  enable = true,

	  -- Disable treesitter highlight based on file size
	  disable = function(lang, buf)
	      local max_filesize = 100 * 1024 -- 100 KB
	      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
	      if ok and stats and stats.size > max_filesize then
		  return true
	      end
	  end,

	  additional_vim_regex_highlighting = false,
	},
      }
    end,
  }
}
