-- Nightfox theme with customed colors

local M = {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    config = function()
        local opts = {
            options = {
                transparent = false,
                styles = {
                    comments = "italic",
                },
            },
        }

        -- customed palette
        -- local helix = require("q3yi.theme.color.helix")
        -- local acme = require("q3yi.theme.color.acme")
        -- opts = helix.apply(opts)
        -- opts = acme.apply(opts)
        require("nightfox").setup(opts)
    end,
    init = function()
        vim.api.nvim_create_autocmd("OptionSet", {
            pattern = "background",
            callback = function()
                if vim.o.background == "light" and vim.g.fox_theme ~= "dayfox" then
                    vim.g.fox_theme = "dayfox"
                    vim.cmd.colorscheme("dayfox")
                end
                if vim.o.background == "dark" and vim.g.fox_theme ~= "nightfox" then
                    vim.g.fox_theme = "nightfox"
                    vim.cmd.colorscheme("nightfox")
                end
            end,
        })
    end,
}

return M
