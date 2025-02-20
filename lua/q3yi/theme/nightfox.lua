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
        vim.keymap.set({ "n", "v" }, "<leader>utd", "<cmd>colorscheme dayfox<cr>", { desc = "dayfox" })
        vim.keymap.set({ "n", "v" }, "<leader>utn", "<cmd>colorscheme nightfox<cr>", { desc = "nightfox" })
        vim.keymap.set({ "n", "v" }, "<leader>utu", "<cmd>colorscheme duskfox<cr>", { desc = "duskfox" })
        vim.keymap.set({ "n", "v" }, "<leader>utw", "<cmd>colorscheme dawnfox<cr>", { desc = "dawnfox" })

        vim.api.nvim_create_autocmd("OptionSet", {
            pattern = "background",
            callback = function()
                if vim.o.background == "light" then
                    vim.cmd.colorscheme("dayfox")
                else
                    vim.cmd.colorscheme("nightfox")
                end
            end,
        })
    end,
}

return M
