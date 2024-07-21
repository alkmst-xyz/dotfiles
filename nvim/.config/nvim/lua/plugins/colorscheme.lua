return {

  -- Default colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "storm",
      transparent = true,
    },
    config = function(_, opts)
      require("tokyonight").load(opts)
    end,
  },

}
