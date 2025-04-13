-- telescope fuzzy Finder

local M = {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable("make") == 1
                end,
            },
        },
    },
}

-- register keys before telescope module loaded
M.keys = {
    { "<M-x>", "<cmd>Telescope commands<cr>", desc = "Execute command" },
    { "<leader>x", "<cmd>Telescope builtin<cr>", desc = "List telescope buildin pickers" },
    { "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "List all buffer" },
    { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>F", "<cmd>Telescope oldfiles<cr>", desc = "Recent opened files" },
    {
        "<leader>/",
        function()
            require("telescope.builtin").current_buffer_fuzzy_find(
                require("telescope.themes").get_ivy({ previewer = false })
            )
        end,
        desc = "Fuzzily search in current buffer",
    },
    { "<leader>wg", "<cmd>Telescope git_files<cr>", desc = "Search file in workspace git" },
    { "<leader>wr", "<cmd>Telescope live_grep<cr>", desc = "Search in workspace files" },
    { "<leader>dw", "<cmd>Telescope diagnostics<cr>", desc = "Search diagnostics in workspace" },
    { "<leader>h", "<cmd>Telescope help_tags<cr>", desc = "Search help" },
    { "<leader>i", "<cmd>Telescope treesitter<cr>", desc = "Imenu-like function base on treesitter" },
    { "<leader>m", "<cmd>Telescope marks<cr>", desc = "List all marks" },
    { "<leader>q", "<cmd>Telescope quickfix<cr>", desc = "Quickfix" },
}

function M.config()
    local telescope = require("telescope")

    telescope.setup({
        defaults = {
            borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            sorting_strategy = "ascending",
            layout_strategy = "horizontal",
            layout_config = {
                horizontal = {
                    prompt_position = "top",
                },
            },
            -- preview = {
            --     filesize_limit = 2,  -- only preview file less than 2MB.
            -- }
        },
    })

    pcall(telescope.load_extension, "fzf")
end

return M
