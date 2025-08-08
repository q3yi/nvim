-- Show you pending keybinds.

local WhichKey = {
    "folke/which-key.nvim",
    event = "VeryLazy",
    dependencies = {
        "echasnovski/mini.icons",
    },
}

function WhichKey.config()
    local wk = require("which-key")
    wk.setup({
        preset = "helix",
        -- delay = 500,
        -- icons = { rules = false },
        show_help = false,
        win = {
            border = "single",
        },
    })
    wk.add({
        { "<leader>b", group = "Buffers" },
        { "<leader>w", group = "Workspace" },
        { "<leader>d", group = "Diagnostic" },
        { "<leader>g", group = "Git" },
        { "<leader>s", group = "Swap textobjects" },
        { "<leader>u", group = "Options" },
        { "<leader>r", group = "Obsidian" },
    })
end

return WhichKey
