-- Config nvim statusline

local MiniStatus = {
    "echasnovski/mini.statusline",
    version = false,
    config = function()
        require("mini.statusline").setup({})
    end,
}

return MiniStatus
