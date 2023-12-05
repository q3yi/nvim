-- Install mini.comment plugin. 

local M = {
    "echasnovski/mini.comment",
    version = false,
    keys = {"gc"},
    config = function()
        require("mini.comment").setup()
    end
}

return M
