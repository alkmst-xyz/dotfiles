--[[
-- Config init
--]]
 
-- Set <space> as the leader key
-- NOTE: This should be set before loading lazy.nvim and plugins.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("options")
require("keymaps")
require("lazy_init")
-- require("config.autocommands")
