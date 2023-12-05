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
            transparent_background = true,
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
                which_key = true,
                mini = { enabled = true },
            }
        }
        vim.cmd.colorscheme "catppuccin"
    end,
}

local MiniStatus = {
    "echasnovski/mini.statusline",
    version = false,
    config = function()
        require("mini.statusline").setup({})
    end
}

return { CatppuccinTheme, MiniStatus, }
