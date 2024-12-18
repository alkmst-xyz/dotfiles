-- Refresh the init file
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")

-- Execute line
vim.keymap.set("n", "<space>x", ":.lua<CR>")

-- Execute selected lines
vim.keymap.set("v", "<space>x", ":lua<CR>")

-- Open a terminal at bottom
vim.keymap.set("n", "<space>st", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 15)
end)

-- Quit terminal mode faster
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
