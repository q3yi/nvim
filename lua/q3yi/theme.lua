-- Set color theme and status line

local CatppuccinTheme = {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup {
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            background = {
                light = "latte",
                dark = "mocha",
            },
            -- transparent_background = true,
            styles = {
                conditionals = {},
            },
            integrations = {
                cmp = true,
                fidget = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                neogit = true,
                mason = true,
                lsp_trouble = true,
                which_key = true,
                mini = { enabled = true },
            }
        }
        vim.cmd.colorscheme "catppuccin"
    end,
}

-- local TokyonightTheme = {
--     "folke/tokyonight.nvim",
--     priority = 1000,
--     config = function()
--         require("tokyonight").setup {
--             -- transparent = true,
--             style = "moon",
--             styles = {
--                 keywords = {},
--                 -- sidebars = "transparent",
--                 -- floats = "transparent",
--             }
--         }
--         vim.cmd.colorscheme "tokyonight"
--     end
-- }

local MiniStatus = {
    "echasnovski/mini.statusline",
    version = false,
    config = function()
        require("mini.statusline").setup({})
    end
}

return {
    CatppuccinTheme,
    -- TokyonightTheme,
    MiniStatus,
}
