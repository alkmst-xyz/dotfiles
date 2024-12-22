-- Refresh the init file
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")

-- Execute line
vim.keymap.set("n", "<space>x", ":.lua<CR>")

-- Execute selected lines
vim.keymap.set("v", "<space>x", ":lua<CR>")
