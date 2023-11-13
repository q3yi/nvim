-- Set color theme and status line

-- local DoomOneTheme = {
--     "NTBBloodbath/doom-one.nvim",
--     config = function()
--         vim.g.doom_one_terminal_colors = true
--         vim.g.doom_one_italic_comments = true
--         vim.g.doom_one_enable_treesitter = true
--         -- Color whole diagnostic text or only underline
--         vim.g.doom_one_diagnostics_text_color = false
--         -- Enable transparent background
--         vim.g.doom_one_transparent_background = false
--
--         -- Pumblend transparency
--         vim.g.doom_one_pumblend_enable = false
--         vim.g.doom_one_pumblend_transparency = 20
--
--         vim.g.doom_one_plugin_telescope = true
--         vim.g.doom_one_plugin_neogit = true
--         vim.g.doom_one_plugin_nvim_tree = true
--         vim.g.doom_one_plugin_whichkey = true
--         vim.g.doom_one_plugin_indent_blankline = true
--
--         -- vim.cmd [[colorscheme doom-one]]
--     end
-- }

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
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                indent_blankline = { enabled = true },
                neogit = true,
            }
        }
        vim.cmd.colorscheme "catppuccin"
    end,
}

local Ibl = {
    -- Add indentation guides even on blank lines
    "lukas-reineke/indent-blankline.nvim",
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = "ibl",
    opts = {},
}

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
            component_separators = { left = "\\", right = "/" },
            section_separators = { left = '', right = '' },
            -- disabled_filetypes = {
            --     statusline = { "NvimTree" },
            -- },
        },
    },
}

return { CatppuccinTheme, Lualine, Ibl, }
