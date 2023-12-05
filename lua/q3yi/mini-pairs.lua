-- mini.pairs,

local M = {
    "echasnovski/mini.pairs",
    version = false,
    event = "InsertEnter",
    config = function()
        require("mini.pairs").setup({})
    end
}

return M
