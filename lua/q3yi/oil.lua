-- load oil.nvim

return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = { "VeryLazy" },
    -- cmd = { "Oil" },
    config = function()
        require("oil").setup({
            -- columns = { "icon", "permissions", "size", "mtime" },
            keymaps = {
                ["<C-h>"] = false,
                ["<C-s>"] = false,
                ["<C-t>"] = false,
                ["<M-s>"] = {
                    "actions.select",
                    opts = { horizontal = true },
                    desc = "Open the entry in a horizontal split",
                },
                ["<M-v>"] = {
                    "actions.select",
                    opts = { vertical = true },
                    desc = "Open the entry in a vertical split",
                },
                ["<M-t>"] = {
                    "actions.select",
                    opts = { tab = true },
                    desc = "Open the entry in new tab",
                },
                ["gl"] = {
                    desc = "Toggle file detail view",
                    callback = function()
                        vim.g.oil_show_detail = not vim.g.oil_show_detail
                        if vim.g.oil_show_detail then
                            require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
                        else
                            require("oil").set_columns({ "icon" })
                        end
                    end,
                },
            },
            view_options = {
                show_hidden = true,
            },
            float = { border = "single" },
            preview = { border = "single" },
            progress = { border = "single" },
            ssh = { border = "none" },
            keymaps_help = { border = "none" },
        })

        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
        vim.keymap.set("n", "<space>-", require("oil").toggle_float, { desc = "Open directory in float window" })
    end,
}
