-- nvim-surround plugin
-- Change surround with vim text-objects

local M = {
    "kylechui/nvim-surround",
    event = "VeryLazy",
}

function M.config()
    require("nvim-surround").setup {}
end

return M
