-- Show you pending keybinds.

local WhichKey = {
    "folke/which-key.nvim",
    event = "VeryLazy",
}

function WhichKey.config()
    local wk = require("which-key")
    wk.setup({
        icons = { rules = false },
    })
    wk.add({
        { "<leader>b", group = "Buffers" },
        { "<leader>w", group = "Workspace" },
        { "<leader>l", group = "LSP" },
        { "<leader>d", group = "Diagnostic" },
        { "<leader>s", group = "Swap textobjects" },
        { "<leader>u", group = "Options" },
        { "<leader>r", group = "Obsidian" },
    })
end

return WhichKey
