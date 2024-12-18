-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Customize terminal
vim.api.nvim_create_autocmd("TermOpen", {
  desc = "",
  group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
  callback = function()
    vim.opt.number = false
    -- vim.opt.relativenumber = false
    --     vim.highlight.on_yank()
  end,
})
