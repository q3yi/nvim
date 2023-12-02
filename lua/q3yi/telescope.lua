-- telescope fuzzy Finder

local M = {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    cmd = "Telescope",
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        },
    },
}

-- register keys before telescope module loaded
M.keys = {
    { "<leader>x", "<cmd>Telescope commands<cr>",   desc = "Execute command" },
    { "<leader>b", "<cmd>Telescope buffers<cr>",    desc = "Switch buffer" },
    { "<leader>B", "<cmd>Telescope builtin<cr>",    desc = "List telescope buildin pickers" },
    { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>F", "<cmd>Telescope oldfiles<cr>",   desc = "Recent opened files" },
    {
        "<leader>/",
        function()
            require("telescope.builtin").current_buffer_fuzzy_find(
                require("telescope.themes").get_ivy { previewer = false }
            )
        end,
        desc = "Fuzzily search in current buffer"
    },
    { "<leader>wg", "<cmd>Telescope git_files<cr>",   desc = "Search file in workspace git" },
    { "<leader>wr", "<cmd>Telescope live_grep<cr>",   desc = "Search in workspace files" },
    { "<leader>dw", "<cmd>Telescope diagnostics<cr>", desc = "Search diagnostics in workspace" },
    { "<leader>h",  "<cmd>Telescope help_tags<cr>",   desc = "Search help" },
}

function M.config()
    local telescope = require("telescope")
    local themes = require("telescope.themes")
    local dropdown_no_preview = themes.get_dropdown { previewer = false };
    local ivy_no_preview = themes.get_ivy { previewer = false };

    telescope.setup {
        defaults = {
            mappings = {
                i = {
                    ['<C-u>'] = false,
                    ['<C-d>'] = false,
                },
            },
        },
        pickers = {
            buffers = dropdown_no_preview,
            commands = ivy_no_preview,
            builtin = dropdown_no_preview,
            keymaps = ivy_no_preview,
            find_files = dropdown_no_preview,
            git_files = dropdown_no_preview,
            oldfiles = dropdown_no_preview,
            help_tags = dropdown_no_preview,
            diagnostics = themes.get_dropdown(),
        },
    }

    pcall(telescope.load_extension, "fzf")
end

return M
