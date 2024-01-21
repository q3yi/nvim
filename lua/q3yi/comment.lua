-- config comment library

local M = {
    "numToStr/Comment.nvim",
    -- keys = { "gcc", "gb" },
    event = { "VeryLazy" },
    config = function()
        require("Comment").setup()
    end
}

return M
