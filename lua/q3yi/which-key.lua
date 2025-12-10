-- Show you pending keybinds.

local WhichKey = {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        -- preset = "helix",
        delay = 500,
        spec = {
            { "<leader>b", group = "Buffers" },
            { "<leader>d", group = "Debugger" },
            { "<leader>w", group = "Workspace" },
            { "<leader>g", group = "Git" },
            { "<leader>u", group = "Options" },
            { "<leader>r", group = "Obsidian" },
        },
    },
}

return WhichKey
