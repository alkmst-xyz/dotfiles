-- return a list of plugins
return {
    {
        'echasnovski/mini.nvim',
	-- enabled = false -- optionally enable plugins
	config = function()
	    local statusline = require("mini.statusline")
	    statusline.setup({use_icons = true})
	end
    },
}
