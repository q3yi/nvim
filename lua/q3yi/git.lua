-- Config git extension

local NeoGit = {
    "NeogitOrg/neogit",
    cmd = { "Neogit" },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = true,
}

vim.keymap.set("n", "<leader>v", "<cmd>Neogit<cr>")

local GitSigns = {
    "lewis6991/gitsigns.nvim",
    opts = {
        -- See `:help gitsigns.txt`
        -- signs = {
        --     add          = { text = "│" },
        --     change       = { text = "│" },
        --     delete       = { text = "_" },
        --     topdelete    = { text = "‾" },
        --     changedelete = { text = "~" },
        --     untracked    = { text = "┆" },
        -- },
    },
}

return { NeoGit, GitSigns }
