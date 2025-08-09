-- config yazi explorer

local M = {
    "mikavilpas/yazi.nvim",
    cmd = { "Yazi" },
    dependencies = {
        -- check the installation instructions at
        -- https://github.com/folke/snacks.nvim
        "folke/snacks.nvim",
    },
    keys = {
        {
            "-",
            "<cmd>Yazi<cr>",
            desc = "Open yazi at the current file",
        },
        {
            -- Open in the current working directory
            "<leader>-",
            "<cmd>Yazi cwd<cr>",
            desc = "Open yazi in nvim's working directory",
        },
        {
            "<c-up>",
            "<cmd>Yazi toggle<cr>",
            desc = "Resume the last yazi session",
        },
    },
    opts = {
        open_for_directories = true,
        keymaps = {
            show_help = "<f1>",
        },
        yazi_floating_window_border = "rounded",
    },
}

return M
