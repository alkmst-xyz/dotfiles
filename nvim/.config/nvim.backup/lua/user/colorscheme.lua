-- tokyonight
vim.g.tokyonight_style = "night"
vim.g.tokyonight_hide_inactive_statusline = true
vim.cmd [[
try
  colorscheme tokyonight 
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]

-- dracula
-- vim.cmd [[
-- try
--   colorscheme dracula
-- catch /^Vim\%((\a\+)\)\=:E185/
--   colorscheme default
--   set background=dark
-- endtry
-- ]]

-- transparend background
-- :hi! Normal ctermbg=NONE guibg=NONE
-- :hi! NonText ctermbg=NONE guibg=NONE
-- vim.cmd [[
-- highlight Normal ctermbg=NONE guibg=NONE
-- ]]
