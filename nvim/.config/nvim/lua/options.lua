--[[
-- Options
--]]

local opt = vim.opt

-- previews substitutions in a split window
opt.inccommand = "split"

-- ignore case in searching, but override when uppercase is used
opt.smartcase = true
opt.ignorecase = true

opt.hlsearch = false

opt.number = true
-- opt.relativenumber = true

opt.mouse = "a"

opt.clipboard = "unnamedplus"

opt.breakindent = true

opt.undofile = true

opt.signcolumn = "yes"

-- decrease update time
opt.updatetime = 250
opt.timeout = true
opt.timeoutlen = 300

opt.completeopt = 'menuone,noselect'

opt.termguicolors = true

opt.smartindent = true

-- prevents creating a swapfile
opt.swapfile = false
opt.backup = false

-- insert 2 spaces for each indentation or tab
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.cursorline = true

-- turn off text wrapping
-- number of lines to show vertically/horizontally when scrolling
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8

-- opt.cmdheight = 1               -- more space in the neovim command line for displaying messages
-- opt.pumheight = 10              -- pop up menu height
--
-- opt.showmode = false            -- we don't need to see things like -- INSERT -- anymore
-- 
-- opt.splitbelow = true           -- force all horizontal splits to go below current window
-- opt.splitright = true           -- force all vertical splits to go to the right of current window
-- 
-- opt.guifont = "monospace:h17"   -- the font used in graphical neovim applications

