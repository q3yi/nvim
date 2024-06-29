-- Show colors in nvim

local Colorizer = {
    "NvChad/nvim-colorizer.lua",
    cmd = { "ColorizerToggle", "ColorizerAttachToBuffer" },
    config = function()
        require("colorizer").setup({
            filetype = {
                "*",
            },
        })
    end,
}

return Colorizer
