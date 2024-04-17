-- Nightfox theme with customed colors

local M = {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    config = function()
        local helix = require("q3yi.theme.color.helix")
        local acme = require("q3yi.theme.color.acme")
        require("nightfox").setup({
            palettes = {
                dayfox = acme.palette,
                nightfox = helix.palette,
            },
            specs = {
                dayfox = acme.spec,
                nightfox = helix.spec,
            },
            options = {
                styles = {
                    comments = "italic"
                },
            }
        })

        vim.cmd.colorscheme "nightfox"
    end
}

return M
