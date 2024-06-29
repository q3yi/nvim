-- Show you pending keybinds.

local WhichKey = {
    "folke/which-key.nvim",
    event = "VeryLazy",
}

function WhichKey.config()
    local wk = require("which-key")
    wk.register({
        ["<leader>b"] = { name = "Buffers", _ = "which_key_ignore" },
        ["<leader>w"] = { name = "Workspace", _ = "which_key_ignore" },
        ["<leader>l"] = { name = "LSP", _ = "which_key_ignore" },
        ["<leader>d"] = { name = "Diagnostic", _ = "which_key_ignore" },
        ["<leader>s"] = { name = "Swap textobjects", _ = "which_key_ignore" },
        ["<leader>u"] = { name = "Options", _ = "which_key_ignore" },
    })
end

return WhichKey
