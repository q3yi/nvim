-- obsidian plugin

local M = {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    cmd = { "ObsidianQuickSwitch", "ObsidianSearch" },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        { "<leader>rf", "<cmd>ObsidianQuickSwitch<cr>", "Find file in Roam" },
        { "<leader>rs", "<cmd>ObsidianSearch<cr>",      "Search keywords in Roam" },
        { "<leader>rn", "<cmd>ObsidianNew<cr>",         "Create new note in Roam" },
        { "<leader>rt", "<cmd>ObsidianTemplate<cr>",    "Insert a template into note" },
    },
    config = function()
        require("obsidian").setup({
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
                date_format = "%Y-%m-%d",
                time_format = "%H:%M:%S"
            },
            new_notes_location = "./",
            note_id_func = function(title)
                local suffix = ""
                if title ~= nil then
                    suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
                else
                    for _ = 1, 4 do
                        suffix = suffix .. string.char(math.random(65, 90))
                    end
                end
                return os.date("%Y%m%d%H%M", os.time()) .. "-" .. suffix
            end
        })
    end,
}

return M
