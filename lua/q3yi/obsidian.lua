-- obsidian plugin
---@diagnostic disable: missing-fields

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
        { "<leader>rf", "<cmd>ObsidianQuickSwitch<cr>", desc = "Find file in Roam" },
        { "<leader>rs", "<cmd>ObsidianSearch<cr>", desc = "Search keywords in Roam" },
        { "<leader>rn", "<cmd>ObsidianNew<cr>", desc = "Create new note in Roam" },
        { "<leader>rt", "<cmd>ObsidianTemplate<cr>", desc = "Insert a template into note" },
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
                subdir = "_templates",
                date_format = "%Y-%m-%d",
                time_format = "%H:%M:%S",
            },
            attachments = {
                img_folder = "_static",
            },
            new_notes_location = "./",
            note_id_func = function(title)
                -- don't add any prefix of suffix to my title
                return title
            end,
            note_frontmatter_func = function(note)
                local out = {
                    -- id = note.id,
                    aliases = note.aliases,
                    tags = note.tags,
                }

                -- `note.metadata` contains any manually added fields in the frontmatter.
                -- So here we just make sure those fields are kept in the frontmatter.
                if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                    for k, v in pairs(note.metadata) do
                        out[k] = v
                    end
                end

                if out.created_at == nil then
                    out.created_at = os.date("%Y-%m-%dT%H:%M:%S", os.time())
                end

                return out
            end,
        })
    end,
}

return M
