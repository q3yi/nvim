-- Nightfox theme with customed colors

local M = {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    config = function()
        local helix = require("q3yi.theme.color.helix")
        local acme = require("q3yi.theme.color.acme")

        local opts = {
            options = {
                styles = {
                    comments = "italic"
                },
            },
        }

        opts = helix.apply(opts)
        opts = acme.apply(opts)

        require("nightfox").setup(opts)

        vim.cmd.colorscheme "nightfox"
    end
}

return M
