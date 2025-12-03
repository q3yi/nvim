-- flash.nvim like jump

local M = {
    "echasnovski/mini.jump2d",
    version = false,
    event = "VeryLazy",

    config = function()
        require("mini.jump2d").setup({
            view = { dim = true },
            mappings = {
                start_jumping = "gs",
            },
        })
    end,
}

return M
