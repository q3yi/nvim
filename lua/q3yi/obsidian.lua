-- obsidian plugin

local M = {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        workspaces = {
            {
                name = "Roam",
                path = "~/Roam",
            },
        },
        ui = {
            enable = false,
        },
        templates = {
            subdir = "Templates",
        },
    },
}

return M
