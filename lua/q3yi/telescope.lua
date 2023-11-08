-- telescope fuzzy Finder

local M = {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
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

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
function M.config()
    local telescope = require("telescope")

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
            buffers = { theme = "ivy" },
            commands = { theme = "ivy" },
            find_files = { theme = "ivy" },
            oldfiles = { theme = "ivy" },
            git_files = { theme = "ivy" },
            help_tags = { theme = "ivy" },
        },
    }

    pcall(telescope.load_extension, "fzf")

    local kmap = vim.keymap.set
    local builtin = require("telescope.builtin")

    kmap("n", "<leader>x", builtin.commands, { desc = "Execute command" })
    kmap("n", "<leader>b", builtin.buffers, { desc = "Switch buffer" })
    kmap("n", "<leader>f", builtin.find_files, { desc = "Find files" })
    kmap("n", "<leader>F", builtin.oldfiles, { desc = "Recent opened files" })
    kmap("n", "<leader>/", function()
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_ivy {
            previewer = false,
        })
    end, { desc = "Fuzzily search in current buffer" })

    kmap("n", "<leader>wg", builtin.git_files, { desc = "Search file in workspace git" })
    kmap("n", "<leader>wr", builtin.live_grep, { desc = "Search in workspace files" })

    kmap("n", "<leader>dw", builtin.diagnostics, { desc = "Search diagnostics in workspace" })

    kmap("n", "<leader>h", builtin.help_tags, { desc = "Search help" })
end

return M
