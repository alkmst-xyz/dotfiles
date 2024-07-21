-- [[ Keymaps ]]

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode easyily 
-- NOTE: This won't work in all terminal emulators/tmux/etc.
-- Try your own mapping or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
-- Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- TODO: revise usage

-- -- helper function
-- local function map(mode, lhs, rhs, opts)
--   opts = opts or {}
--   opts.silent = opts.silent ~= false
--   vim.keymap.set(mode, lhs, rhs, opts)
-- end
-- 
-- map({ 'n', 'v' }, '<Space>', '<Nop>')
-- 
-- -- remap for dealing with word wrap
-- map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- 
-- -- window navigation
-- map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
-- map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
-- map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
-- map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
-- 
-- -- resize windows using <ctrl> + arrow keys
-- map("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
-- map("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
-- map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
-- map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })
-- 
-- -- navigate buffers
-- map("n", "<S-l>", ":bnext<CR>", { desc = "Prev buffer" })
-- map("n", "<S-h>", ":bprevious<CR>", { desc = "Next buffer" })
-- 
-- -- move line up and down
-- map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
-- map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
-- map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
-- map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
-- 
-- -- indenting
-- map("v", "<", "<gv", { desc = "Indent left" })
-- map("v", ">", ">gv", { desc = "Indent right" })

-- -- move text up and down as visual block
-- map("x", "J", ":move '>+1<CR>gv-gv", { desc = "Move block down" })
-- map("x", "K", ":move '<-2<CR>gv-gv", { desc = "Move block up" })
-- map("x", "<A-j>", ":move '>+1<CR>gv-gv", { desc = "Move block down" })
-- map("x", "<A-k>", ":move '<-2<CR>gv-gv", { desc = "Move block up" })
