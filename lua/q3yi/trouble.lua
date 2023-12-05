-- trouble list

local M = {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "Trouble", "TroubleToggle", },
    opts = {},
}

function M.config()
    require("trouble").setup {
        mode = "document_diagnostics",
        action_keys = {
            open_split = { "<c-s>" },
        },
        auto_preview = false,
    }
end

local kmap = vim.keymap.set

kmap({ "n" }, "<leader>da", "<cmd>TroubleToggle document_diagnostics<cr>",
    { desc = "Open buffer diagnostics list in trouble" })
kmap({ "n" }, "<leader>dl", "<cmd>TroubleToggle loclist<cr>", { desc = "Open location list in trouble" })

kmap({ "n" }, "<leader>wd", "<cmd>TroubleToggle workspace_diagnostics<cr>",
    { desc = "Open workspace diagnostics list in trouble" })
kmap({ "n" }, "<leader>wq", "<cmd>TroubleToggle quickfix<cr>", { desc = "Open quickfix list in trouble" })

return M
