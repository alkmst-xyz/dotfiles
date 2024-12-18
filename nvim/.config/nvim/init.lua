require("config.lazy")

-- options
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true

-- keymaps
-- refresh the init file
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")

-- execute line
vim.keymap.set("n", "<space>x", ":.lua<CR>")

-- execute selected lines
vim.keymap.set("v", "<space>x", ":lua<CR>")

-- Auto command to highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})


-- Auto command to highlight when yanking text
vim.api.nvim_create_autocmd("TermOpen", {
  desc = "",
  group = vim.api.nvim_create_augroup("custome-term-open", { clear = true }),
  callback = function()
    vim.opt.number = false
    -- vim.opt.relativenumber = false
    --     vim.highlight.on_yank()
  end,
})

-- Open a terminal at bottom
vim.keymap.set("n", "<space>st", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 15)
end)

-- Quit terminal mode faster
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
