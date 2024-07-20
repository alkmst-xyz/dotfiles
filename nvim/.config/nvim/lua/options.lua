--[[
-- Options
--]]

-- set highlight on search
vim.o.hlsearch = false

-- make line numbers default
vim.wo.number = true

-- enable mouse mode
vim.o.mouse = "a"

-- sync clipboard between OS and neovim
vim.o.clipboard = "unnamedplus"

-- enable break indent
vim.o.breakindent = true

-- enable persistent undo
vim.o.undofile = true

-- ignore case in searching, but override when uppercase is used
vim.o.ignorecase = true
vim.o.smartcase = true

-- always show signcolumn
vim.o.signcolumn = "yes"

-- decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- better completion experience
vim.o.completeopt = 'menuone,noselect'

-- most terminals support this
vim.o.termguicolors = true

-- for smart indenting
vim.o.smartindent = true

-- prevents creating a swapfile
vim.o.swapfile = false
vim.o.backup = false


-- insert 2 spaces for each indentation or tab
-- convert tab to spaces
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- highlight the current line
vim.o.cursorline = true

-- turn off text wrapping
-- number of lines to show vertically/horizontally when scrolling
vim.o.wrap = false
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8


-- -- still considering
-- cmdheight = 1, -- more space in the neovim command line for displaying messages
-- pumheight = 10, -- pop up menu height

-- showmode = false, -- we don't need to see things like -- INSERT -- anymore

-- splitbelow = true, -- force all horizontal splits to go below current window
-- splitright = true, -- force all vertical splits to go to the right of current window

-- relativenumber = false, -- set relative numbered lines

-- guifont = "monospace:h17", -- the font used in graphical neovim applications
