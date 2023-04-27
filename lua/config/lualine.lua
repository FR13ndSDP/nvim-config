local M = {}

local lualine = require "lualine"

function M.setup()
	lualine.setup{
		options = { 
			theme = 'gruvbox-material',
		},
	}
end

return M
