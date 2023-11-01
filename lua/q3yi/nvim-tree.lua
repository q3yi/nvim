-- Install nvim-tree extension

local M = {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
}

function M.config()
    local nvim_tree = require("nvim-tree")

    nvim_tree.setup {
        disable_netrw = true,
        hijack_netrw = true,
    }
end

vim.keymap.set("n", "<leader>t", "<cmd>NvimTreeToggle<cr>", { noremap = true, silent = true })

return M
