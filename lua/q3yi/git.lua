-- Config git extension

local GitSigns = {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost" },
    opts = {
        -- See `:help gitsigns.txt`
    },
    keys = {
        { "]h",               "<cmd>Gitsigns next_hunk<cr>",                 desc = "Goto next hunk",        mode = { "n" } },
        { "[h",               "<cmd>Gitsigns prev_hunk<cr>",                 desc = "Goto prev hunk",        mode = { "n" } },
        { "<leader>gB",       "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle inlay blame",    mode = { "n" } },
        { "<leader>gd",       "<cmd>Gitsigns preview_hunk_inline<cr>",       desc = "Show hunk diff inline", mode = { "n" } },
        { "<leader>g<space>", "<cmd>Gitsigns stage_hunk<cr>",                desc = "Stage hunk",            mode = { "n" } },
        { "<leader>gx",       "<cmd>Gitsigns reset_hunk<cr>",                desc = "Discard hunk",          mode = { "n" } },
        { "<leader>gl",       "<cmd>Gitsigns blame_line<cr>",                desc = "Git blame line",        mode = { "n" } },
    },
}

return { GitSigns }
