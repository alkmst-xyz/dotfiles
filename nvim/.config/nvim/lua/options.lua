-- [[ Options ]]

local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.mouse = "a"

opt.showmode = false

opt.clipboard = "unnamedplus"

opt.breakindent = true

opt.swapfile = false
opt.backup = false
opt.undofile = true

-- Case-insensitive searching, unless uppercase is used
opt.ignorecase = true
opt.smartcase = true

opt.signcolumn = "yes"

-- Decrease update time and mapped sequence wait time (displays which-key sooner)
opt.updatetime = 250
opt.timeoutlen = 300

opt.splitbelow = true
opt.splitright = true

-- Set how neovim displays whitespace characters
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
-- opt.listchars = { tab = '» ', trail = '·', nbsp = '␣', eol = '↲' }

-- Substitutions are previewed in a split window
opt.inccommand = "split"

opt.cursorline = true

-- TODO: move to after/ per language config
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.wrap = true
opt.linebreak = true

-- Number of lines to show vertically/horizontally when scrolling
opt.scrolloff = 10
opt.sidescrolloff = 8

opt.smartindent = true

opt.termguicolors = true

-- opt.completeopt = 'menuone,noselect'

-- opt.cmdheight = 1               -- more space in the neovim command line for displaying messages
-- opt.pumheight = 10              -- pop up menu height
--
-- opt.guifont = "monospace:h17"   -- the font used in graphical neovim applications
