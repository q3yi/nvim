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
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                indent_blankline = { enabled = true },
                neogit = true,
                which_key = true,
            }
        }
        vim.cmd.colorscheme "catppuccin"
    end,
}

-- local Ibl = {
--     -- Add indentation guides even on blank lines
--     "lukas-reineke/indent-blankline.nvim",
--     -- Enable `lukas-reineke/indent-blankline.nvim`
--     -- See `:help ibl`
--     main = "ibl",
--     cmd = { "IBLToggle" },
--     opts = {},
-- }

local Lualine = {
    -- Set lualine as statusline
    "nvim-lualine/lualine.nvim",
    -- See `:help lualine.txt`
    opts = {
        options = {
            icons_enabled = true,
            -- theme = "auto",
            theme = "catppuccin",
            -- component_separators = "|",
            -- section_separators = "",
            -- component_separators = { left = "\\", right = "/" },
            -- section_separators = { left = '', right = '' },
            -- disabled_filetypes = {
            --     statusline = { "NvimTree" },
            -- },
        },
    },
}

return { CatppuccinTheme, Lualine, }
