-- Show you pending keybinds.

local WhichKey = {
    "folke/which-key.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
}

function WhichKey.config()
    local wk = require("which-key")
    wk.setup({
        -- preset = "helix",
        -- delay = 500,
        -- icons = { rules = false },
        win = {
            -- border = "single",
            -- wo = { winhighlight = "Normal:WhichKeyNormal,Normal:WhichKey" }, -- FIXME: not work, why?
        },
    })
    wk.add({
        { "<leader>b", group = "Buffers" },
        { "<leader>w", group = "Workspace" },
        { "<leader>l", group = "LSP" },
        { "<leader>d", group = "Diagnostic" },
        { "<leader>g", group = "Git" },
        { "<leader>s", group = "Swap textobjects" },
        { "<leader>u", group = "Options" },
        { "<leader>r", group = "Obsidian" },
    })
end

return WhichKey
